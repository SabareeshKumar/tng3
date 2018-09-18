import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_components/material_button/material_button.dart';

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
    MaterialButtonComponent,
  ],  
)
class AddUserComponent {
  final UserService _userService;
  final Router _router;
  Map<String, String> _fieldErrors;
  
  bool hasError = false;
  String globalError;

  @Input()
  String userName;

  @Input()
  String age;

  @Input()
  String emailId;
  
  AddUserComponent(this._userService, this._router);
  
  void add() async {
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
    //    if ( hasError && hasFieldError('name')) userName.error = fieldError('name');
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
