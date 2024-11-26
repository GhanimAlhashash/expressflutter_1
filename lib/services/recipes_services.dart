import 'package:dio/dio.dart';
import 'package:expressflutter_1/model/recipes.dart';
import 'package:expressflutter_1/services/client.dart';

class RecipesServices {
  static Future<List<Recipes>> list() async {
    var response = await Client.dio.get('/recipe');
    var recipesJson = response.data['data']['recipes'] as List;
    return recipesJson.map(Recipes.fromjson).toList();
  }

  Future<List<Recipes>> getRecipes() async {
    List<Recipes> recipes = [];
    try {
      Response response = await Client.dio.get('/recipe');
      recipes = (response.data as List).map((recipe) => Recipes.fromjson(recipe)).toList();
    } on DioError catch (error) {
      print(error);
    }
    return recipes;
  }

  static Future<Recipes> createRecipe(String name, String description,
      String image, String category, String ingredients, String author, String id) async {
    var response = await Client.dio.post('/recipe', data: {
      "name": name,
      "description": description,
      "image": image,
      "category": category,
      "ingredients": ingredients,
      "author": author,
      "id": id
    });
    var recipesJson = response.data['data'];
    return Recipes.fromjson(recipesJson);
  }
}
