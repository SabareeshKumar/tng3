import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'list_user_component.template.dart' as list_user_template;
import 'add_user_component.template.dart' as add_user_template;
import 'edit_user_component.template.dart' as edit_user_template;

export 'route_paths.dart';

class Routes {
    static final users =
        RouteDefinition(
                        routePath: RoutePaths.users,
                        component: list_user_template.ListUserComponentNgFactory,
                        );

    static final add =
        RouteDefinition(
                        routePath: RoutePaths.add,
                        component: add_user_template
                        .AddUserComponentNgFactory,
                        );

    static final edit =
        RouteDefinition(
                        routePath: RoutePaths.edit,
                        component:
                        edit_user_template.EditUserComponentNgFactory,
                        );

    static final all =
        <RouteDefinition>[
                          users,
                          add,
                          edit,
                          RouteDefinition
                          .redirect(
                                    path: '',
                                    redirectTo: RoutePaths.users.toUrl(),
                                    ),
                          ];
}
