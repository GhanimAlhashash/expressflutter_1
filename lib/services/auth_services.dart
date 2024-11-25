import 'package:expressflutter_1/model/User.dart';
import 'package:expressflutter_1/services/client.dart';

Future<User> signupAPI(String email, String password) async {
  var response = await dio.post("/signup", data: {
    "email": email,
    "password": password,
  });

  return User.fromjson(response.data['data']);
}

Future<User> loginApi(String email, String password) async {
  var response = await dio.post("/login", data: {
    "email": email,
    "password": password,
  });

  return User.fromjson(response.data['data']);
}
