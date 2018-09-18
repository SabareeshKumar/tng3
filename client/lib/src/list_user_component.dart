import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'edit_user_component.dart';
import 'route_paths.dart';
import 'user.dart';
import 'user_service.dart';

@Component(
  selector: 'list-user',
  templateUrl: 'list_user_component.html',
  styleUrls: ['list_user_component.css'],
  directives: [coreDirectives, formDirectives, EditUserComponent],
)
class ListUserComponent implements OnInit {
  
  final UserService _userService;
  final Router _router;
  List<User> users;
  User selected;
  
  ListUserComponent(this._userService, this._router);
  
  void ngOnInit() async {
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
