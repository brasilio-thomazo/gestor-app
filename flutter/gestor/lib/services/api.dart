import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gestor/models/response.dart';
import 'package:gestor/models/role.dart';
import 'package:gestor/models/user.dart';
import 'package:gestor/providers/app.dart';
import 'package:http/http.dart' as http;

class Api {
  final String baseURL = dotenv.get('API_URL', fallback: 'http://127.0.0.1');
  final String token = AppProvider.appProvider.user.value.token;
  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-type': 'application/json',
  };

  Uri _uri(String path) => Uri.parse('$baseURL/$path');

  Future<dynamic> login(String body) async {
    final response = await http.post(
      _uri('auth'),
      headers: headers,
      body: body,
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final user = User.fromJson(data['user']);
      user.token = data['token'];
      return user;
    }
    return Response.fromJson(data);
  }

  Future<dynamic> users() async {
    final headers = {...this.headers, 'Authorization': 'Bearer $token'};
    final response = await http.get(_uri('user'), headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => User.fromJson(e)).toList();
    }
    return Response.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> userUpdate(User user) async {
    final headers = {...this.headers, 'Authorization': 'Bearer $token'};
    final body = jsonEncode(user.toMap());
    final response = await http.put(
      _uri('user/${user.id}'),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    return Response.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> roles() async {
    final response = await http.get(_uri('role'), headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Role.fromJson(e)).toList();
    }
    return Response.fromJson(jsonDecode(response.body));
  }

  // _ApiError error = _ApiError(code: 0, message: '');

  // Uri _uri(String path) => Uri.parse('$baseURL/$path');

  // Future<dynamic> userList() async {
  //   final response = await http.get(_uri('user'), headers: headers);
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = jsonDecode(response.body);
  //     return data.map((e) => User.fromJson(e)).toList();
  //   }
  //   return UserResponse.fromJson(jsonDecode(response.body));
  // }

  // Future<dynamic> userUpdate(UserRequest request) async {
  //   final response = await http.put(
  //     _uri('user/${request.id}'),
  //     headers: headers,
  //     body: request.toJson(),
  //   );

  //   if (response.statusCode == 200) {
  //     return User.fromJson(jsonDecode(response.body));
  //   }
  //   return UserResponse.fromJson(jsonDecode(response.body));
  // }

  // Future<dynamic> userStore(UserRequest request) async {
  //   final response = await http.post(
  //     _uri('user'),
  //     headers: headers,
  //     body: request.toJson(),
  //   );

  //   if (response.statusCode == 200) {
  //     return User.fromJson(jsonDecode(response.body));
  //   }

  //   return UserResponse.fromJson(jsonDecode(response.body));
  // }
}
