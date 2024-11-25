// import 'package:expressflutter_1/providers/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("recipe"),
//       ),
//       drawer: Drawer(
//           child: FutureBuilder(
//         future: context.read<AuthProvider>().initializeAuth(),
//         builder: (context, dataSnapshot) => Consumer<AuthProvider>(
//           builder: (context, authProvider, child) => authProvider.isAuth()
//               ? ListView(
//                   padding: EdgeInsets.zero,
//                   children: [
//                     DrawerHeader(
//                         child: Text("welcome ${authProvider.user.username}")),
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
//               future: Provider.of<RecipesProvider>(context, listen: false)
//                   .getRecipes(),
//               builder: (context, dataSnapshot) {
//                 if (dataSnapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   if (dataSnapshot.error != null) {
//                     return const Center(
//                       child: Text('An error occurred'),
//                     );
//                   } else {
//                     return Consumer<RecipesProvider>(
//                       builder: (context, recipesProvider, child) =>
//                           GridView.builder(
//                               shrinkWrap: true,
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 childAspectRatio:
//                                     MediaQuery.of(context).size.width /
//                                         (MediaQuery.of(context).size.height),
//                               ),
//                               physics:
//                                   const NeverScrollableScrollPhysics(), // <- Here
//                               itemCount: recipesProvider.Recipes.length,
//                               itemBuilder: (context, index) => RecipeCard(
//                                   recipe: recipesProvider.recipes[index])),
//                     );
//                   }
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
