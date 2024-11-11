import 'package:flutter/material.dart';
import 'package:frontend/Services/location_service.dart';
import 'package:geolocator/geolocator.dart';

class RegisterScreenMechanic extends StatefulWidget {
  @override
  State<RegisterScreenMechanic> createState() => _RegisterScreenMechanicState();
}

class _RegisterScreenMechanicState extends State<RegisterScreenMechanic> {
  String? _currentAddress;
  double? _latitude;
  double? _longitude;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final LocationService _locationService = LocationService();

  void _locateUser() async {
    try {
      Position position = await _locationService.determinePosition();
      final address = await _locationService.getAddress();

      setState(() {
        _currentAddress = address;
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    } catch (e) {
      print("Error while getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registracija mehaničara '),
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
            // Ispis trenutne adrese ili poruke o nedostatku adrese
            Text(_currentAddress ?? "No location selected"),
            ElevatedButton(
              onPressed: _locateUser, // Pozivanje funkcije za dohvat lokacije
              child: Text('Get Current Location'),
            ),
            ElevatedButton(
              onPressed: () {
                // Dodaj registraciju mehaničara ovdje
              },
              child: Text('Register Mechanic'),
            )
          ],
        ),
      ),
    );
  }
}
