import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'user.dart';
import 'user_service.dart';
import 'route_paths.dart';

@Component(
  selector: 'add-user',
  templateUrl: 'add_user_component.html',
  styleUrls: ['add_user_component.css'],
  directives: [routerDirectives, coreDirectives, formDirectives],
  
)
class AddUserComponent {
  
    Map<String, dynamic> error_message = {};
    final UserService _userService;
    final Router _router;
    
    AddUserComponent(this._userService, this._router);
  
    void add(String name, String age, String email_id) async {
        var response  = await _userService.add(name, age, email_id);
        if (response == null) {
            var home_route = RoutePaths.users
                .toUrl(parameters: {});
            _router.navigate(home_route);
        } else {
            response.forEach((dict) =>
                             error_message[dict['name']] = dict['description']);
        }
    }
}
	
