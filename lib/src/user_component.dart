import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'user.dart';
import 'user_service.dart';
import 'route_paths.dart';
import 'list_user_component.dart';

@Component(
  selector: 'my-user',
  templateUrl: 'user_component.html',
  styleUrls: ['user_component.css'],
  directives: [coreDirectives, formDirectives, ListUserComponent],
)
class UserComponent implements OnActivate {
  
  User user;

  final UserService _userService;

  final Location _location;
  final Router _router;
  
  UserComponent(this._userService, this._location, this._router);
  
  @override
  void onActivate(_, RouterState current) async {
    final id = getId(current.parameters);
    if (id != null) {
      user = await _userService.get(id);
    }
  }

  void goBack() => _location.back();

  void save() async {
       await _userService.update(user);
       _router.navigate(RoutePaths.users.toUrl());
  }
}
	