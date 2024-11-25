import 'package:expressflutter_1/pages/home.dart';
import 'package:expressflutter_1/pages/login.dart';
import 'package:expressflutter_1/pages/register.dart';
import 'package:expressflutter_1/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider<PetsProvider>(create: (_) => PetsProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
    routes: [
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => const HomePage(),
      // ),

      GoRoute(
        path: '/signup',
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => LoginPage(),
      ),
      // GoRoute(
      //   path: '/update/:recipeId',
      //   builder: (context, state) {
      //     final recipe = Provider.of<RecipesProvider>(context).recipes.firstWhere(
      //         (recipe) => recipe.id.toString() == (state.pathParameters['recipeId']!));
      //     return UpdatePage(recipe: recipe);
      //   },
      // ),
    ],
  );
}
