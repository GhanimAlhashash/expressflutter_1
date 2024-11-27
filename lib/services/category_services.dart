import 'package:dio/dio.dart';
import 'package:expressflutter_1/model/categories.dart';
import 'package:expressflutter_1/model/ingredients.dart';
import 'package:expressflutter_1/services/client.dart';

class CategoryServices {
  static Future<List<Category>> list() async {
    var response = await Client.dio.get('/category');
    var categories = response.data['data']['catagories'] as List;
    return categories.map(Category.fromjson).toList();
  }

  Future<List<Category>> getCategories() async {
    List<Category> categories = [];
    try {
      Response response = await Client.dio.get('/category');
      categories = (response.data as List).map((category) => Category.fromjson(category)).toList();
    } on DioError catch (error) {
      print(error);
    }
    return categories;
  }
}