import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/Services/login.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final loginService = LoginService();
                loginService.login(
                    context, usernameController.text, passwordController.text);
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register_driver');
              },
              child: Text(' Registrirajte se kao vozač'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register_mechanic');
              },
              child: Text('Registrirajte se kao mehaničar'),
            )
          ],
        ),
      ),
    );
  }
}
