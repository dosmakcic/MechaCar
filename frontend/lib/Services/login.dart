import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<void> login(
      BuildContext context, String email, String password) async {
    final url = Uri.parse('http://localhost:8080/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final userType = data['type'];
      final userId = data['id'];

      if (userType == 'driver') {
        Navigator.pushReplacementNamed(context, '/driver_home',
            arguments: {'id': userId});
      } else if (userType == 'mechanic') {
        Navigator.pushReplacementNamed(context, '/mechanic_home',
            arguments: {'id': userId});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid email or password')));
      }
    }
  }
}
