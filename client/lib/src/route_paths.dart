import 'package:angular_router/angular_router.dart';

const idParam = 'id';

dynamic getId(Map<String, String> parameters) {
      final id = parameters[idParam];
      return id == null ? null : id;
}

class RoutePaths {
      static final users = RoutePath(path : '/users');
      static final add = RoutePath(path : "${users.path}/add");
      static final edit = RoutePath(path : "${users.path}/edit/:$idParam");
}
