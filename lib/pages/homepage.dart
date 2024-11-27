
// import 'package:flutter/material.dart';
// import 'package:expressflutter_1/providers/auth_provider.dart';
// import 'package:expressflutter_1/providers/recipes_provider.dart';
// import 'package:expressflutter_1/widgets/recipes_card.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Recipe Book"),
//       ),
//       drawer: Drawer(
//           child: FutureBuilder(
//         future: context.read<AuthProvider>().getToken(),
//         builder: (context, dataSnapshot) => Consumer<AuthProvider>(
//           builder: (context, authProvider, child) => authProvider.isAuth()
//               ? ListView(
//                   padding: EdgeInsets.zero,
//                   children: [
//                     DrawerHeader(
//                         child: Text("welcome ${authProvider.user}")),
//                     ListTile(
//                       title: Text("logout"),
//                       trailing: const Icon(Icons.logout),
//                       onTap: () {
//                         context.read<AuthProvider>().logout();
//                       },
//                     ),
//                   ],
//                 )
//               : ListView(
//                   padding: EdgeInsets.zero,
//                   children: [
//                     DrawerHeader(
//                       child: Text("Sign in please"),
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     ListTile(
//                       title: Text("Sign in"),
//                       trailing: Icon(Icons.login),
//                       onTap: () {
//                         GoRouter.of(context).push('/signin');
//                       },
//                     ),
//                     ListTile(
//                       title: Text("Sign up"),
//                       trailing: Icon(Icons.how_to_reg),
//                       onTap: () {
//                         context.push('/signup');
//                       },
//                     ),
//                   ],
//                 ),
//         ),
//       )),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   GoRouter.of(context).push('/add');
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all(12.0),
//                   child: Text("Add a new recipe"),
//                 ),
//               ),
//             ),
//             FutureBuilder(
//               future:
//                   Provider.of<RecipesProvider>(context, listen: false).getRecipes(),
//               builder: (context, dataSnapshot) {
//                 if (dataSnapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//   child: CircularProgressIndicator(),
// );
// } else {
//   if (dataSnapshot.error != null) {
//     return const Center(
//       child: Text('An error occurred'),
//     );
//   } else {
//     return Consumer<RecipesProvider>(
//       builder: (context, recipesProvider, child) {
//         if (recipesProvider.recipes.isEmpty) {
//           return const Center(
//             child: Text('No recipes found'),
//           );
//         } else {
//           return GridView.builder(
//             shrinkWrap: true,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: MediaQuery.of(context).size.width /
//                   (MediaQuery.of(context).size.height),
//             ),
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: recipesProvider.recipes.length,
//             itemBuilder: (context, index) {
//               final recipe = recipesProvider.recipes[index];
//               return RecipeCard(recipes: recipe);
//             },
//           );
//         }
//       },
//     );
//   }
// }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:expressflutter_1/providers/auth_provider.dart';
import 'package:expressflutter_1/providers/recipes_provider.dart';
import 'package:expressflutter_1/widgets/recipes_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Book"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.push('/profile');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: FutureBuilder(
          future: context.read<AuthProvider>().getToken(),
          builder: (context, dataSnapshot) => Consumer<AuthProvider>(
            builder: (context, authProvider, child) => authProvider.isAuth()
                ? ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                          child: Text("welcome ${authProvider.user}")),
                      ListTile(
                        title: Text("logout"),
                        trailing: const Icon(Icons.logout),
                        onTap: () {
                          context.read<AuthProvider>().logout();
                        },
                      ),
                    ],
                  )
                : ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        child: Text("Sign in please"),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                      ListTile(
                        title: Text("Sign in"),
                        trailing: Icon(Icons.login),
                        onTap: () {
                          GoRouter.of(context).push('/signin');
                        },
                      ),
                      ListTile(
                        title: Text("Sign up"),
                        trailing: Icon(Icons.how_to_reg),
                        onTap: () {
                          context.push('/signup');
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search recipes...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: selectedCategory,
                isExpanded: true,
                items: <String>['All', 'Breakfast', 'Lunch', 'Dinner', 'Dessert']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
            ),
            FutureBuilder(
              future: Provider.of<RecipesProvider>(context, listen: false).getRecipes(),
              builder: (context, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapshot.error != null) {
                    return const Center(
                      child: Text('An error occurred'),
                    );
                  } else {
                    return Consumer<RecipesProvider>(
                      builder: (context, recipesProvider, child) {
                        final filteredRecipes = recipesProvider.recipes.where((recipe) {
                          final matchesSearchQuery = recipe.name.toLowerCase().contains(searchQuery.toLowerCase());
                          final matchesCategory = selectedCategory == 'All' || recipe.category == selectedCategory;
                          return matchesSearchQuery && matchesCategory;
                        }).toList();

                        if (filteredRecipes.isEmpty) {
                          return const Center(
                            child: Text('No recipes found'),
                          );
                        } else {
                          return GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: MediaQuery.of(context).size.width /
                                  (MediaQuery.of(context).size.height),
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredRecipes.length,
                            itemBuilder: (context, index) {
                              final recipe = filteredRecipes[index];
                              return RecipeCard(recipes: recipe);
                            },
                          );
                        }
                      },
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add-recipe');
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}