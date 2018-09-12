import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'user.dart';
import 'user_service.dart';
import 'route_paths.dart';

@Component(
  selector: 'my-user',
  templateUrl: 'user_component.html',
  styleUrls: ['user_component.css'],
  directives: [coreDirectives, formDirectives],
)
class UserComponent implements OnActivate {
  
  User user;

  final UserService _userService;

  final Location _location;
  
  UserComponent(this._userService, this._location);
  
  @override
  void onActivate(_, RouterState current) {
    final id = getId(current.parameters);
    if (id != null) user = _userService.get(id);
  }

  void goBack() => _location.back();

  void save() async {
       await _userService.update(user);
       goBack();
  }
}
	