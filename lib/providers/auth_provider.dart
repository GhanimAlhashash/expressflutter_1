
import 'dart:io';

import 'package:expressflutter_1/model/User.dart';
import 'package:expressflutter_1/services/auth_services.dart';
import 'package:expressflutter_1/services/client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User? user;
  bool _isUserLoggedInBefore = false; // if logged in previously

  bool get isUserLoggedInBefore => _isUserLoggedInBefore;

  Future<void> signup({required String username, required String password}) async {
    user = await signupAPI(username, password);

    notifyListeners();

    dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    var prefs = await SharedPreferences.getInstance();
    prefs.setString("username", user!.username);
    prefs.setString("token", user!.token);
    _isUserLoggedInBefore = true; // Update login state after successful signup
  }

  Future<void> loadPreviousUser() async {
    var prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var token = prefs.getString("token");

    if (username == null || token == null) {
      prefs.remove("username");
      prefs.remove("token");
      return;
    }

    dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";

    user = User(token: token, username: username);
    _isUserLoggedInBefore = true; // User has previously logged in

    notifyListeners();
  }

  Future<void> login({required String username, required String password}) async {
    user = await loginApi(username, password);

    notifyListeners();

    dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    var prefs = await SharedPreferences.getInstance();
    prefs.setString("username", user!.username);
    prefs.setString("token", user!.token);
    _isUserLoggedInBefore = true; // Update login state after successful login
  }

  // Method to log in using the previously stored token if biometric authentication is valid
  Future<void> loginWithStoredCredentials() async {
    var prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var token = prefs.getString("token");

    if (username != null && token != null) {
      dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      user = User(token: token, username: username);
      notifyListeners();
    } else {
      // If no previous credentials, prompt regular login
      print("No stored credentials found.");
    }
  }

  void logout() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    user = null;
    dio.options.headers.remove(HttpHeaders.authorizationHeader);
    notifyListeners();
  }
}

