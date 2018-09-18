import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'src/route_paths.dart';
import 'src/routes.dart';
import 'src/user_service.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: [routerDirectives],
  exports: [Routes, RoutePaths],
  providers: [ClassProvider(UserService)],
)
class AppComponent {
  var title = 'Users';
}
