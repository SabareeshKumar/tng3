import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'user.dart';
import 'user_service.dart';
import 'route_paths.dart';
import 'edit_user_component.dart';

@Component(
  selector: 'list-user',
  templateUrl: 'list_user_component.html',
  styleUrls: ['list_user_component.css'],
  directives: [coreDirectives, formDirectives, EditUserComponent],
)
class ListUserComponent implements OnInit {
  
  List<User> users;

  final UserService _userService;

  final Router _router;
  
  User selected;
  
  ListUserComponent(this._userService, this._router);
  
  void ngOnInit() async {
    users = await _userService.getAll();
  }
       
  void onSelect(User user) {
       selected = user;
       _router.navigate(RoutePaths.edit.toUrl(parameters: {idParam: '${selected.id}'}));
  }

  void delete(User user) async {
       users = await _userService.delete(user);
       selected = null;
  }  
}
	