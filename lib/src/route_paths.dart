import 'package:angular_router/angular_router.dart';

const idParam = 'id';

int getId(Map<String, String> parameters) {
      final id = parameters[idParam];
      return id == null ? null : int.tryParse(id);
}

class RoutePaths {
      static final users = RoutePath(path : 'users');
      static final add = RoutePath(path : "${users.path}/add");
      static final edit = RoutePath(path : "${users.path}/edit/:$idParam");
      // static final delete = RoutePath(path : "${users.path}/delete");
      //static final hero = RoutePath(path: "${heroes.path}/:$idParam");
}