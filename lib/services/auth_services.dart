import 'package:expressflutter_1/model/User.dart';
import 'package:expressflutter_1/services/client.dart';

Future<User> signupAPI(String username, String password) async {
  var response = await dio.post("/auth/signup", data: {
    "username": username,
    "password": password,
  });

  return User.fromjson(response.data['data']);
}

Future<User> loginApi(String username, String password) async {
  var response = await dio.post("/auth/signin", data: {
    "username": username,
    "password": password,
  });

  return User.fromjson(response.data['data']);
}
