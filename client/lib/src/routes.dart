import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'list_user_component.template.dart' as list_user_template;
import 'add_user_component.template.dart' as add_user_template;
import 'edit_user_component.template.dart' as edit_user_template;
//import 'delete_user_component.template.dart' as delete_user_template;
//import 'hero_component.template.dart' as hero_template;
export 'route_paths.dart';

class Routes {
  static final users = RouteDefinition(
  	 routePath: RoutePaths.users,
  	 component: list_user_template.ListUserComponentNgFactory,
  );

  static final add = RouteDefinition(
  	 routePath: RoutePaths.add,
	 component: add_user_template.AddUserComponentNgFactory,
	 );

 static final edit = RouteDefinition(
  	 routePath: RoutePaths.edit,
	 component: edit_user_template.EditUserComponentNgFactory,
	 );

/*
  static final delete = RouteDefinition(
  	 routePath: RoutePaths.delete,
	 component: delete_user_template.DeleteUserComponentNgFactory,
	 );


  static final hero = RouteDefinition(
  	 routePath: RoutePaths.hero,
	 component: hero_template.HeroComponentNgFactory,
	 );
*/	 
  static final all = <RouteDefinition>[
  	 users,
    	 add,
	 edit,
    	 RouteDefinition.redirect(
		path: '',
    		redirectTo: RoutePaths.users.toUrl(),
 	 ),
	// hero,
  ];
}
