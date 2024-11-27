

import 'package:expressflutter_1/model/ingredients.dart';
import 'package:expressflutter_1/services/ingredients_service.dart';
import 'package:flutter/material.dart';

class IngredientsProvider extends ChangeNotifier {
  List<Ingredients> ingredients = [];

  // Future<void> get() async {
  //   recipes = await RecipesServices.list();
  //   notifyListeners();
  // }
  Future<void> getIngredients() async {
    ingredients = await IngredientsService().getIngredients();
  }
}