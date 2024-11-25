import 'package:expressflutter_1/widgets/add_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/second',
        builder: (context, state) => SecondPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfilePage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => AddRecipeForm(),
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