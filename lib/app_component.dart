import 'package:angular/angular.dart';

import 'src/user.dart';
import 'src/user_component.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: [coreDirectives, UserComponent],
  styleUrls: ['app_component.css'],
)
class AppComponent {
  var name = 'Users';
  var selected;
  var users = [
      User(1, "Nithya", 22, "nithyag@gmail.com"),
      User(2, "Saba", 21, "saba@gmail.com"),
  ];

  void onSelect(User user) {
       selected = user;
  }
  void delete(User user) {
       users.removeWhere((item) => item.id == user.id);
  }
}
