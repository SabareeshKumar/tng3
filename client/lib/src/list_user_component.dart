import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/material_button/material_button.dart';

import 'edit_user_component.dart';
import 'route_paths.dart';
import 'routes.dart';
import 'user.dart';
import 'user_service.dart';

@Component(
  selector: 'list-user',
  templateUrl: 'list_user_component.html',
  styleUrls: ['list_user_component.css'],
  exports: [RoutePaths],
  directives: [
    coreDirectives,
    formDirectives,
    EditUserComponent,
    MaterialButtonComponent,
    routerDirectives,
  ],
)
class ListUserComponent implements OnActivate, OnInit {

  final UserService _userService;
  final Router _router;
  List<User> users;
  User selected;

  ListUserComponent(this._userService, this._router);

  void ngOnInit() async {
    users = await _userService.getAll();
  }

  @override
  void onActivate(_, RouterState current) async {
    users = await _userService.getAll();
  }

  void onSelect(User user) {
    selected = user;
    var editRoute = RoutePaths.edit
      .toUrl(parameters: {idParam: '${selected.id}'});
    _router.navigate(editRoute);
  }

  void delete(User user) async {
    await _userService.delete(user);
    selected = null;
    users = await _userService.getAll();
  }
}
