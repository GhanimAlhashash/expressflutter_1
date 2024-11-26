import 'package:expressflutter_1/model/recipes.dart';
import 'package:expressflutter_1/services/client.dart';

class RecipesServices {
  static Future<List<Recipes>> list() async {
    var response = await Client.dio.get('/recipe');
    var recipesJson = response.data['data']['recipes'] as List;
    return recipesJson.map(Recipes.fromjson).toList();
  }

  static Future<Recipes> createAccount(String name, String description,
      String image, String category, String ingredients, String author) async {
    var response = await Client.dio.post('/recipe', data: {
      "name": name,
      "description": description,
      "image": image,
      "category": category,
      "ingredients": ingredients,
      "author": author
    });
    var recipesJson = response.data['data'];
    return Recipes.fromjson(recipesJson);
  }
}
