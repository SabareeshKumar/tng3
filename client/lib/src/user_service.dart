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

  String _globalError = "";
  Map<String, String> _fieldErrors = {};

  String get globalError => _globalError;
  Map<String, String> get fieldErrors => _fieldErrors;
  
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

  _extractErrorResponse(Response resp) {
    _globalError = "${resp.statusCode} : ${resp.reasonPhrase}";
    final errorList = json.decode(resp.body)["errors"];
    _fieldErrors.clear();
    for (var e in errorList) {
      _fieldErrors[e["name"]] = e["description"];
    }
  }

  Future<bool> add(String name, String age, String email_id) async {
    var response;
    var data = json.encode({"name": name,
                            "age": age,
                            "email_id": email_id});
    try {
      response = await _http.post(
        _usersUrl,
        headers: _headers,
        body: data);
      
      if (response.statusCode == 200) {
        return true;
      }
      _extractErrorResponse(response);
    } catch (e) {
      print("Error occurred while adding user: $e");
    }
    return false;
  }
  
  delete(User user) async {
    try {
      final url = '$_usersUrl/${user.id}';
      final response = await _http.delete(url, headers: _headers);
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  get(dynamic id) async {
    try {
      final url = '$_usersUrl/$id';
      final response = await _http.get(url);
      if (response.statusCode == 200) {
        final User user = User.fromJson(_extractData(response));
        return user;
      }
      _extractErrorResponse(response);
    } catch (e) {
      print("Error occurred while retrieving user: $e");
    }
    return null;
  }
  
  Future<bool> update(int id, String name, String age, String emailId) async {
    var response;
    try {
      final url = '$_usersUrl/$id';
      var data = json.encode({"name": name,
                              "age": age,
                              "email_id": emailId});
      response = await _http.put(
        url,
        headers: _headers,
        body: data);
      if (response.statusCode == 200) {
        return true;
      }
      _extractErrorResponse(response);
    } catch (e) {
      print("Error occurred while updating user: $e");
    }
    return false;
  }
}
