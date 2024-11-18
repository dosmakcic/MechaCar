import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreenDriver extends StatefulWidget {
  @override
  _RegisterScreenDriverState createState() => _RegisterScreenDriverState();
}

class _RegisterScreenDriverState extends State<RegisterScreenDriver> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void _registerDriver() async {
    final driverData = {
      'name': nameController.text,
      'email': usernameController.text,
      'password': passwordController.text
    };

    final response = await http.post(
      Uri.parse('http://localhost:8080/driver/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(driverData),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/driver_home');
    }
    if (response.statusCode == 409) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email already in use')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something went wrong')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _registerDriver,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
