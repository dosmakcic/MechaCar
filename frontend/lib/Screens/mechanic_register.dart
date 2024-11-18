import 'package:flutter/material.dart';
import 'package:frontend/Services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class RegisterScreenMechanic extends StatefulWidget {
  @override
  State<RegisterScreenMechanic> createState() => _RegisterScreenMechanicState();
}

class _RegisterScreenMechanicState extends State<RegisterScreenMechanic> {
  String? _currentAddress;
  double? _latitude;
  double? _longitude;
  List<Map<String, dynamic>> _cityOptions = [];
  Map<String, dynamic>? _selectedCity;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
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

  void _searchCities(String query) async {
    if (query.length < 2) return;
    List<Map<String, dynamic>> cities =
        await _locationService.searchCities(query);
    setState(() {
      _cityOptions = cities;
    });
  }

  void _registerMechanic() async {
    final mechanicData = {
      "name": nameController.text,
      "email": usernameController.text,
      "password": passwordController.text,
      "location": _selectedCity != null ? {"id": _selectedCity!["id"]} : null
    };
    final response = await http.post(
      Uri.parse('http://localhost:8080/mechanics/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mechanicData),
    );

    if (response.statusCode == 200) {
      print("Mechanic registered successfully");
      Navigator.pushReplacementNamed(context, '/mechanic_home');
    } else if (response.statusCode == 409) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email already in use')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Resistration failed')));
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
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
              onChanged: _searchCities,
            ),
            DropdownButton<Map<String, dynamic>>(
              value: _selectedCity,
              hint: Text("Select City"),
              items: _cityOptions.map((city) {
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: city,
                  child: Text(city["city"]),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCity = value;
                  cityController.text = value?["city"] ?? "";
                });
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(_currentAddress ?? "No location selected"),
            ElevatedButton(
              onPressed: _locateUser,
              child: Text('Get Current Location'),
            ),
            ElevatedButton(
              onPressed: _registerMechanic,
              child: Text('Register Mechanic'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/login'),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
