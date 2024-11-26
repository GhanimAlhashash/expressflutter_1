import 'dart:io';
import 'package:expressflutter_1/model/User.dart';
import 'package:expressflutter_1/services/auth_services.dart';
import 'package:expressflutter_1/services/client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String token = ""; //"error", "email", "token"
  User? user;

  Future<Map<String, String>> signup({required String username, required String password}) async {
    var response = await AuthServices().signupAPI(user: User(username: username, password: password));
    if (response['token'] != null) {
      _setToken(username, response['token']!);
    }
    print(response['token'] ?? 'No token');
    notifyListeners();
    return response;
  }

  Future<String> login({required String username, required String password}) async {
    token = await AuthServices().loginApi(user: User(username: username, password: password));
    // this.user = user;
    _setToken(username, token);
    // print(token);
    user = User(username: username, password: password);
    notifyListeners();
    return token;
  }

  bool isAuth() {
    return (user != null && token.isEmpty);
  }

  Future<void> initAuth() async {
    await _getToken();
    if (isAuth()) {
      Client.dio.options.headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
      user = User(username: user!.username, password: token);
      print('Bearer $token');
      notifyListeners();
    }
  }

  void _setToken(String username, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username);
    prefs.setString("token", token);
    notifyListeners();
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var token = prefs.getString("token");

    if (username == null || token == null) return;

    user = User(username: username, password: token);
    notifyListeners();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('token');
    user = null;
    notifyListeners();
  }
}