import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'user.dart';
import 'user_service.dart';
import 'route_paths.dart';
import 'list_user_component.dart';

@Component(
  selector: 'my-user',
  templateUrl: 'edit_user_component.html',
  styleUrls: ['edit_user_component.css'],
  directives: [
    coreDirectives,
    formDirectives,
    ListUserComponent,
    routerDirectives,
  ],
)
class EditUserComponent implements OnActivate {
  
  User user;

  final UserService _userService;
  Map<String, dynamic> error_message = {};
  Router _router;
  Location _location;

  bool hasError = false;
  String globalError;
  Map<String, String> _fieldErrors;

  EditUserComponent(this._userService, this._router, this._location);
  
  @override
  void onActivate(_, RouterState current) async {
    final id = getId(current.parameters);    
    if (id != null) {
      final res = await _userService.get(id);
      if (res is User) {
        user = res;
        hasError = false;
        return;
      }
      hasError = true;
      user = null;
      globalError = _userService.globalError;
      _fieldErrors = _userService.fieldErrors;
    }
  }

  void goBack() => _location.back();
    
  void save(String name, String age, String emailId) async {
    final res = await _userService.update(user.id, name, age, emailId);
    if (res) {
      hasError = false;
      var home_route = RoutePaths.users.toUrl();
      _router.navigate(home_route);
      return;
    }
    hasError = true;
    globalError = _userService.globalError;
    _fieldErrors = _userService.fieldErrors;
  }

  bool hasFieldError(String fieldName) {
    return _fieldErrors.containsKey(fieldName);
  }

  String fieldError(String fieldName) => _fieldErrors[fieldName];
}
	
