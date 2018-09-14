
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
    print(e);
    return Exception('Server error; cause: $e');
  }
  void add(String name, String age, String emailId) async {
    try {
      final response = await _http.post(_usersUrl,
          headers: _headers, body: json.encode({'name': name, 'age': age, 'email_id': emailId }));
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
  
  Future<User> get(int id) async {
    try {
      final url = '$_usersUrl/$id';
      final response = await _http.get(url);
      final User user = User.fromJson(_extractData(response));
      return user;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<void> update(User user) async {
    try {
      final url = '$_usersUrl/${user.id}';
      final response = await _http.put(url, headers: _headers, body: json.encode(user));
    } catch (e) {
      throw _handleError(e);
    }
  }
}