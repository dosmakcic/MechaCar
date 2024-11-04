import 'package:flutter/material.dart';

class RegisterScreenMechanic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController cityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Registracija mehaničara'),
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
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                  labelText: 'Email'), // Ostavite ovo bez provjera
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
              onPressed: () {
                // Ne provjeravajte format, samo šaljite podatke
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
