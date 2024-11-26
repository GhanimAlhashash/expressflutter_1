import 'package:dio/dio.dart';
import 'package:expressflutter_1/model/User.dart';
import 'package:expressflutter_1/services/client.dart';

class AuthServices {

  Future<Map<String, String>> signupAPI({required User user}) async {
    try {
      Response response = await Client.dio.post('/auth/signup', data: user.toJson());
      return {'token': response.data["token"]};
    } on DioException catch (error) {
      print(error.response!.data["error"]["message"]);
      return {'error': error.response!.data["error"]["message"]};
    }
  }

  Future<String> loginApi({required User user}) async {
    late String token;
    try {
      // print(user.toJson());
      Response response =
          await Client.dio.post('/auth/signin', data: user.toJson());
      token = response.data["token"];
      // print(token);
    } on DioException catch (error) {
      print(error.response!);
      return error.response!.data["error"]["message"];
    }
    return token;
  }
}