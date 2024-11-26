import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Sign Up"),
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
                try {} on DioException catch (e) {
                  if (e.response == null) return;
                  if (e.response!.data == null) return;

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          e.response!.data['message'] ?? "Unexpected error")));
                }
              },
              child: const Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}
