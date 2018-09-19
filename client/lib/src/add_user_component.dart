import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_input/material_number_accessor.dart';

import 'route_paths.dart';
import 'user.dart';
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
    materialNumberInputDirectives,
    MaterialButtonComponent,
  ],  
)
class AddUserComponent {
  final UserService _userService;
  final Router _router;
  Map<String, String> _fieldErrors = {};
  
  bool hasError = false;
  String globalError;

  @Input()
  String userName;

  @Input()
  int age;

  @Input()
  String emailId;
  
  AddUserComponent(this._userService, this._router);
  
  void add() async {
    if (isInputValid()) {
      final resp = await _userService.add(userName, age, emailId);
      if (resp) {
        hasError = false;
        var homeRoute = RoutePaths.users.toUrl();
        _router.navigate(homeRoute);
        return;
      }
      hasError = true;
      globalError = _userService.globalError;
      _fieldErrors = _userService.fieldErrors;
    } else {
      hasError = true;
      globalError = "Please fill all the fields";
      clearFieldErrors();
    }
  }

  void clearFieldErrors() {
      if (userName == null) {
        _fieldErrors.remove('name');
      }
      if (age == null) {
        _fieldErrors.remove('age');
      }
      if (emailId == null) {
        _fieldErrors.remove('email_id');
      }
  }

  bool isInputValid() {
    if (userName != null
        && age != null
        && emailId != null) {
      return true;
    }
    return false;
  }
  
  bool hasFieldError(String fieldName) {
    return _fieldErrors.containsKey(fieldName);
  }

  String fieldError(String fieldName) => _fieldErrors[fieldName];

  String getError(String fieldName) {
    if (hasError && hasFieldError(fieldName)) {
      return fieldError(fieldName);
    }
  }
}
