import 'package:dio/dio.dart';
import 'package:expressflutter_1/model/ingredients.dart';
import 'package:expressflutter_1/services/client.dart';

class IngredientsService {
  static Future<List<Ingredients>> list() async {
    var response = await Client.dio.get('/ingredient');
    var ingredients = response.data['data']['ingredients'] as List;
    return ingredients.map(Ingredients.fromjson).toList();
  }

  Future<List<Ingredients>> getIngredients() async {
    List<Ingredients> ingredients = [];
    try {
      Response response = await Client.dio.get('/ingredient');
      ingredients = (response.data as List).map((ingredient) => Ingredients.fromjson(ingredient)).toList();
    } on DioError catch (error) {
      print(error);
    }
    return ingredients;
  }
}