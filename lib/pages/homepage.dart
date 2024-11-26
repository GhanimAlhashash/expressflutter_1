// import 'package:expressflutter_1/model/recipes.dart';
// import 'package:expressflutter_1/services/client.dart';
// import 'package:flutter/material.dart';
// import 'package:expressflutter_1/main.dart';
// import 'package:expressflutter_1/providers/auth_provider.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:flutter/rendering.dart';
// import 'package:dio/dio.dart';




// Future<List<Recipes>> fetchRecipesFromApi() async {
  
//   try {
//     final response = await Client.dio.get('/recipes'); // Replace with your API endpoint
//     List<dynamic> data = response.data;
//     return data.map((json) => Recipes.fromjson(json)).toList();
//   } on DioError catch (e) {
//     print('Error fetching recipes: $e');
//     throw e;
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late Future<List<Recipes>> _recipesFuture;

//   @override
//   void initState() {
//     super.initState();
//     _recipesFuture = fetchRecipesFromApi();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Recipe Book"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.person),
//             onPressed: () {
//               context.push('/profile');
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               child: Text("Welcome User"),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//               ),
//             ),
//             ListTile(
//               title: const Text("Logout"),
//               trailing: const Icon(Icons.logout),
//               onTap: () {
//                 Provider.of<AuthProvider>(context, listen: false).logout();
//                 context.go("/");
//               },
//             ),
//             ListTile(
//               title: const Text("Sign in"),
//               trailing: const Icon(Icons.login),
//               onTap: () {
//                 context.push('/signin');
//               },
//             ),
//             ListTile(
//               title: const Text("Sign up"),
//               trailing: const Icon(Icons.how_to_reg),
//               onTap: () {
//                 context.push('/signup');
//               },
//             ),
//           ],
//         ),
//       ),
//       body: FutureBuilder<List<Recipes>>(
//         future: _recipesFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return const Center(
//               child: Text('An error occurred'),
//             );
//           } else if (snapshot.hasData) {
//             final recipes = snapshot.data!;
//             return ListView.builder(
//               itemCount: recipes.length,
//               itemBuilder: (context, index) {
//                 final recipe = recipes[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text(recipe.name),
//                     subtitle: Text('Description of ${recipe.name}'),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(
//               child: Text('No recipes found'),
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           context.push('/add-recipe');
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: Colors.blue,
//       ),
//     );
//   }
// }


import 'package:expressflutter_1/providers/auth_provider.dart';
import 'package:expressflutter_1/providers/recipes_provider.dart';
import 'package:expressflutter_1/widgets/recipes_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Adopt"),
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
      )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push('/add');
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Add a new Pet"),
                ),
              ),
            ),
            FutureBuilder(
              future:
                  Provider.of<RecipesProvider>(context, listen: false).getRecipes(),
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
        if (recipesProvider.recipes.isEmpty) {
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
            itemCount: recipesProvider.recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipesProvider.recipes[index];
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
    );
  }
}