import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_components/material_button/material_button.dart';

import 'number_validator.dart';
import 'route_paths.dart';
import 'user_service.dart';

@Component(
  selector: 'add-user',
  templateUrl: 'add_user_component.html',
  styleUrls: ['add_user_component.css'],
  directives: [
    routerDirectives,
    coreDirectives,
    formDirectives,
    materialInputDirectives,
    MaterialButtonComponent,
    NumberValidator,
  ],
)
class AddUserComponent {
  final UserService _userService;
  final Router _router;
  Map<String, String> _fieldErrors = {};

  bool hasError = false;
  String globalError;

  String userName;
  String age;
  String emailId;

  @ViewChild("addUserForm")
  NgForm addUserForm;

  AddUserComponent(this._userService, this._router);

  void add() async {
    int iage = int.tryParse(age);
    final resp = await _userService.add(userName, iage, emailId);
    if (resp) {
      hasError = false;
      var homeRoute = RoutePaths.users.toUrl();
      _router.navigate(homeRoute);
      return;
    }
    hasError = true;
    globalError = _userService.globalError;
    _fieldErrors = _userService.fieldErrors;
  }
  void clearFieldErrors() {
    _fieldErrors.clear();
    globalError = null;
  }

  void clearForm() {
    addUserForm.reset();
    clearFieldErrors();
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
