import 'package:angular/angular.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:collection';

import 'user.dart';
import 'route_paths.dart';

class UserService {

  static const _usersUrl = '/api/users';
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

  getErrorMessage(Response resp) {
    var response = json.decode(resp.body);
    if (response.containsKey('errors')) {
       return response['errors'];
    }
  }
  
  Exception _handleError(dynamic e) {
    print(e);
    return Exception('Server error; cause: $e');
  }
  
  add(String name, String age, String email_id) async {
      var response;
      try {
          response = await _http.post(_usersUrl,
                                      headers: _headers,
                                      body: json.encode({"name": name,
                                                         "age": age,
                                                         "email_id": email_id}));
          
          return getErrorMessage(response);
      
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
  
   update(User user) async {
    try {
      final url = '$_usersUrl/${user.id}';
      final response = await _http.put(url, headers: _headers, body: json.encode(user));
      return getErrorMessage(response);
    } catch (e) {
      throw _handleError(e);
    }
  }
}
