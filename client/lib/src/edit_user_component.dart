import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_components/material_input/material_number_accessor.dart';
import 'package:angular_components/material_button/material_button.dart';

import 'list_user_component.dart';
import 'route_paths.dart';
import 'user.dart';
import 'user_service.dart';

@Component(
  selector: 'my-user',
  templateUrl: 'edit_user_component.html',
  styleUrls: ['edit_user_component.css'],
  directives: [
    coreDirectives,
    formDirectives,
    ListUserComponent,
    routerDirectives,
    materialInputDirectives,
    MaterialButtonComponent,
    materialNumberInputDirectives,
  ],
)
class EditUserComponent implements OnActivate {

  final UserService _userService;
  Router _router;
  Location _location;

  Map<String, String> _fieldErrors = {};
  bool hasError = false;
  String globalError;

  User user;
  User originalUser;

  String age;

  @ViewChild("editUserForm")
  NgForm editUserForm;

  EditUserComponent(this._userService, this._router, this._location);

  @override
  void onActivate(_, RouterState current) async {
    final id = getId(current.parameters);
    if (id == null) {
      return;
    }
    final res = await _userService.get(id);
    if (res is User) {
      user = res;
      originalUser = User.from(user);
      hasError = false;
      return;
    }
    hasError = true;
    user = null;
    globalError = _userService.globalError;
    _fieldErrors = _userService.fieldErrors;
  }
  void goBack() => _location.back();

  void save() async {
    final res = await _userService.update(
      user.id,
      user.name,
      user.age,
      user.emailId
    );
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

  void resetForm() {
    user.copy(originalUser);
    clearFieldErrors();
  }

  void clearFieldErrors() {
    _fieldErrors.clear();
    globalError = null;
  }

  bool hasFieldError(String fieldName) {
    return _fieldErrors.containsKey(fieldName);
  }

  String fieldError(String fieldName) => _fieldErrors[fieldName];

  String getError(String fieldName) {
    String errorMsg;
    if (hasError && hasFieldError(fieldName)) {
      errorMsg = fieldError(fieldName);
    }
    return errorMsg;
  }
}
