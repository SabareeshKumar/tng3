import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'user.dart';

@Component(
  selector: 'my-user',
  templateUrl: 'user_component.html',
  styleUrls: ['user_component.css'],
  directives: [coreDirectives, formDirectives],
)
class UserComponent {
  @Input()
  User user;
}
	