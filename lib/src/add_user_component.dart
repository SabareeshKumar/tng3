import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'user.dart';
import 'user_service.dart';

@Component(
  selector: 'add-user',
  templateUrl: 'add_user_component.html',
  styleUrls: ['add_user_component.css'],
  directives: [routerDirectives, coreDirectives, formDirectives],
  
)
class AddUserComponent {
  
  Map<String, dynamic> error_message;
  final UserService _userService;
  final Location _location;

  AddUserComponent(this._userService, this._location);

  void _goBack() => _location.back();
  
  void add(String name, String age, String email_id) async {
    error_message = await _userService.add(name, age, email_id);
    if (error_message == null) {
      _goBack();
    }
  }
}
	