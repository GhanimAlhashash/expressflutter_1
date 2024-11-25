import 'package:expressflutter_1/main.dart';
import 'package:expressflutter_1/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class Recipe {
  final String name;
  final String imageUrl;

  Recipe({required this.name, required this.imageUrl});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}

Future<List<Recipe>> fetchRecipesFromApi() async {
  final response = await http.get(Uri.parse('https://example.com/api/recipes'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Recipe.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load recipes');
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Book"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Dummy profile action
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text("Welcome User"),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: const Text("Logout"),
              trailing: const Icon(Icons.logout),
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              context.go("/");
              },
            ),
            ListTile(
              title: const Text("Sign in"),
              trailing: const Icon(Icons.login),
              onTap: () {
                context.push('/signin');
              },
            ),
            ListTile(
              title: const Text("Sign up"),
              trailing: const Icon(Icons.how_to_reg),
              onTap: () {
                context.push('/signup');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Dummy add recipe action
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Add a new Recipe"),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: fetchRecipesFromApi(),
                  builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error occurred'),
                      );
                    } else if (snapshot.hasData) {
                      final recipes = snapshot.data!;
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height),
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = recipes[index];
                          return Card(
                            child: Column(
                              children: [
                                Image.network(
                                  recipe.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(recipe.name),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('No recipes found'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                // Dummy add recipe action
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
