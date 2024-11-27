

import 'package:expressflutter_1/model/categories.dart';
import 'package:expressflutter_1/model/ingredients.dart';
import 'package:expressflutter_1/services/category_services.dart';
import 'package:expressflutter_1/services/ingredients_service.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories = [];

  // Future<void> get() async {
  //   recipes = await RecipesServices.list();
  //   notifyListeners();
  // }
  Future<void> getCategories() async {
    categories = await CategoryServices().getCategories();
  }
}