import 'package:dio/dio.dart';
import 'package:expressflutter_1/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    usernameController.text = context.read<AuthProvider>().user?.username ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("login"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(""),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email'),
              controller: usernameController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a username' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Password'),
              controller: passwordController,
              obscureText: true,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a password' : null,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // wait for authentication
                  await context.read<AuthProvider>().login(
                      username: usernameController.text,
                      password: passwordController.text);

                  var user = context.read<AuthProvider>().user;
                  print("You are logged in as ${user!.username}");
                  context.pop();
                } on DioException catch (e) {
                  if (e.response == null) return;
                  if (e.response!.data == null) return;

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
               "Unexpected error")));
                }
              },
              child: const Text("login"),
            ),
          ],
        ),
      ),
    );
  }
}
