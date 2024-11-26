import 'package:expressflutter_1/model/recipes.dart';
import 'package:expressflutter_1/pages/homepage.dart';
import 'package:expressflutter_1/services/recipes_services.dart';
import 'package:flutter/material.dart';

class RecipesProvider extends ChangeNotifier {
  List<Recipes> recipes = [];

  Future<void> get() async {
    recipes = await RecipesServices.list();
    notifyListeners();
  }

  Future<void> createRecipe(String name, String description, String image,
      String category, String ingredients, String author) async {
    Recipes newRecipes = await RecipesServices.createAccount(
        name, description, image, category, ingredients, author);
    recipes.insert(0, newRecipes);
    notifyListeners();
  }
}
