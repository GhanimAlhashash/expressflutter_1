// import 'package:dio/dio.dart';
// import 'package:expressflutter_1/providers/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class RegisterPage extends StatelessWidget {
//   RegisterPage({super.key});
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sign up"),
//       ),
//       resizeToAvoidBottomInset: false,
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const Text("Sign Up"),
//             TextFormField(
//               decoration: const InputDecoration(hintText: 'Email'),
//               controller: usernameController,
//               validator: (value) =>
//                   value!.isEmpty ? 'Please enter a username' : null,
//             ),
//             TextFormField(
//               decoration: const InputDecoration(hintText: 'Password'),
//               controller: passwordController,
//               obscureText: true,
//               validator: (value) =>
//                   value!.isEmpty ? 'Please enter a password' : null,
//             ),ElevatedButton(
//               onPressed: () async {
//                 try {
//                   // wait for authentication
//                   await context.read<AuthProvider>().signup(
//                       username: usernameController.text,
//                       password: passwordController.text);

//                   var user = context.read<AuthProvider>().user;
//                   print("You are logged in as ${user!.username}");

//                   context.go('/');
//                 } on DioException catch (e) {
//                   if (e.response == null) return;
//                   if (e.response!.data == null) return;

//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text(
//                           e.response!.data['message'] ?? "Unexpected error")));
//                 }
//               },
//               child: const Text("Sign Up"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
/////////////////////////////////////////////////////
// import 'package:dio/dio.dart';
// import 'package:expressflutter_1/providers/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class RegisterPage extends StatefulWidget {
//   RegisterPage({super.key});

//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sign up"),
//       ),
//       resizeToAvoidBottomInset: false,
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const Text("Sign Up"),
//             TextFormField(
//               decoration: const InputDecoration(hintText: 'Email'),
//               controller: usernameController,
//               validator: (value) =>
//                   value!.isEmpty ? 'Please enter a username' : null,
//             ),
//             TextFormField(
//               decoration: const InputDecoration(hintText: 'Password'),
//               controller: passwordController,
//               obscureText: true,
//             ),
//             TextFormField(
//               decoration: const InputDecoration(hintText: 'Confirm Password'),
//               controller: confirmPasswordController,
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             isLoading
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: () async {
//                       setState(() {
//                         isLoading = true;
//                       });

//                       try {
//                         final authProvider = Provider.of<AuthProvider>(context, listen: false);
//                         final user = await authProvider.signup(
//                           username: usernameController.text,
//                           password: passwordController.text,
//                         );

//                         print("You are logged in as ");
//                         context.go('/');
//                       } on DioException catch (e) {
//                         if (e.response == null) return;
//                         if (e.response!.data == null) return;

//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                             content: Text(
//                                 e.response!.data['message'] ?? "Unexpected error")));
//                       } finally {
//                         setState(() {
//                           isLoading = false;
//                         });
//                       }
//                     },
//                     child: const Text("Sign Up"),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:dio/dio.dart';
import 'package:expressflutter_1/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

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
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Confirm Password'),
              controller: confirmPasswordController,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        final authProvider = Provider.of<AuthProvider>(context, listen: false);
                        await authProvider.signup(
                          username: usernameController.text,
                          password: passwordController.text,
                        );

                        print("You are logged ");
                        context.go('/');
                      } on DioException catch (e) {
                        if (e.response != null && e.response!.data != null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Unexpected error")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Unexpected error")));
                        }
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: const Text("Sign Up"),
                  ),
          ],
        ),
      ),
    );
  }
}