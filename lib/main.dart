import 'package:expressflutter_1/pages/home.dart';
import 'package:expressflutter_1/pages/login.dart';
import 'package:expressflutter_1/pages/register.dart';
import 'package:expressflutter_1/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  final GoRouter _router = GoRouter(
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

    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        ElevatedButton(
          onPressed: () {
            context.go('/second');
          },
          child: Text('Go to Second Page'),
        ),
        ElevatedButton(
          onPressed: () {
            context.go('/profile');
          },
          child: Text('Go to Profile Page'),
        ),
          ],
        ),
      ),
        );
      }
    }

    class SecondPage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
        context.go('/');
          },
          child: Text('Go to Home Page'),
        ),
      ),
        );
      }
    }

    class ProfilePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
        context.go('/');
          },
          child: Text('Go to Home Page'),
        ),
      ),
        );
      }
    }