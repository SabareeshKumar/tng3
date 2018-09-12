import 'package:angular/angular.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

import 'user.dart';
import 'route_paths.dart';

class UserService {

  static const _usersUrl = 'users';
  static final _headers = {'Content-Type': 'application/json'};

  final Client _http;

  UserService(this._http);
  
  Future<List<User>> getAll() async {
    try {
      final response = await _http.get(_usersUrl);
      final List<User> users = (_extractData(response) as List)
      .map((json) => User.fromJson(json))
      .toList();
      return users;
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return Exception('Server error; cause: $e');
  }
  
    var id = 2;

    var _users = [
      User(1, "Nithya", 22, "nithyag@gmail.com"),
      User(2, "Saba", 21, "saba@gmail.com"),
    ];
  
  void add(String name, String age, String emailId) async {
    try {
      final response = await _http.post(_usersUrl,
          headers: _headers, body: json.encode({'name': name, 'age': age, 'email_id': emailId }));
      // return User.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<User>> delete(User user) async {
    try {
      final url = '$_usersUrl/${user.id}';
      final response = await _http.delete(url, headers: _headers);
      final users = (_extractData(response) as List)
        .map((json) => User.fromJson(json))
        .toList();
      return users;
    } catch (e) {
      throw _handleError(e);
    }
  }

  User get(int id) => _users.firstWhere((user) => user.id == id);

  void update(User user) {
      var updated_user = _users.firstWhere((item) => item.id == user.id);
      updated_user = user;
  }
}