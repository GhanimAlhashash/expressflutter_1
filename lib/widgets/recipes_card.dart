
import 'package:expressflutter_1/model/recipes.dart';
import 'package:expressflutter_1/providers/recipes_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RecipeCard extends StatelessWidget {
  final Recipes recipes;
  const RecipeCard({Key? key, required this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              recipes.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(recipes.name),
                  
                  
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            GoRouter.of(context).push('/update/${recipes.id}');
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            Provider.of<RecipesProvider>(context, listen: false);
                                // .deletePet(pet.id!);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}