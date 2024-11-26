import 'package:expressflutter_1/model/recipes.dart';
import 'package:expressflutter_1/pages/homepage.dart';
import 'package:expressflutter_1/services/recipes_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RecipesProvider extends ChangeNotifier {
  List<Recipes> recipes = [];

  // Future<void> get() async {
  //   recipes = await RecipesServices.list();
  //   notifyListeners();
  // }
  Future<void> getRecipes() async {
    recipes = await RecipesServices().getRecipes();
  }

  Future<void> createRecipe(String name, String description, String image,
      String category, String ingredients, String author, String id) async {
    Recipes newRecipes = await RecipesServices.createRecipe(
        name, description, image, category, ingredients, author, id);
    recipes.insert(0, newRecipes);
    notifyListeners();
  }
}
