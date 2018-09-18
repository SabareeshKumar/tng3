import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'user.dart';
import 'user_service.dart';
import 'route_paths.dart';

@Component(
  selector: 'add-user',
  templateUrl: 'add_user_component.html',
  styleUrls: ['add_user_component.css'],
  directives: [routerDirectives, coreDirectives, formDirectives],
  
)
class AddUserComponent {
  final UserService _userService;
  final Router _router;

  bool hasError = false;
  String globalError;
  Map<String, String> _fieldErrors;
  

  AddUserComponent(this._userService, this._router);
  
  void add(String name, String age, String email_id) async {
    final res = await _userService.add(name, age, email_id);
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
	
