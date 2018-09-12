import 'package:angular/angular.dart';
import 'user.dart';

class UserService {

  var id = 2;

  var _users = [
      User(1, "Nithya", 22, "nithyag@gmail.com"),
      User(2, "Saba", 21, "saba@gmail.com"),
  ];

  List<User> getAll() => _users;

  void add(String name, String age, String emailId) {
    _users.add(User(++id, name, int.tryParse(age), emailId));
  }

  void delete(User user) {
    _users.removeWhere((item) => item.id == user.id);
  }

  User get(int id) => _users.firstWhere((user) => user.id == id);

  void update(User user) {
      var updated_user = _users.firstWhere((item) => item.id == user.id);
      updated_user = user;
  }
}
