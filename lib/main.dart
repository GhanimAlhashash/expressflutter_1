
import 'package:expressflutter_1/pages/homepage.dart';
import 'package:expressflutter_1/pages/loginpage.dart';

import 'package:expressflutter_1/pages/profilepage.dart';
import 'package:expressflutter_1/pages/registerpage.dart';
import 'package:expressflutter_1/providers/auth_provider.dart';
import 'package:expressflutter_1/widgets/add_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //ChangeNotifierProvider<PetsProvider>(create: (_) => PetsProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: '/signup',
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/add-recipe',
        builder: (context, state) => AddRecipeForm(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfilePage(),
      ),//'/add-recipe'
      
        ],
      );

      @override
      Widget build(BuildContext context) {
        return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        );
      }
    }

   