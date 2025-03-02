import 'package:flutter/material.dart';
import 'package:get/get.rx.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final username = usernameController.text?.trim() ?? '';
                final password = passwordController.text?.trim() ?? '';
                if (username.isNotEmpty && password.isNotEmpty) {
                  authController.login(username, password);
                  Get.back();
                } else {
                  Get.snackbar('Error', 'Please enter username and password', snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}