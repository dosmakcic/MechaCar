import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationService {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Provera da li je GPS uključen
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are forever denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getAddress() async {
    try {
      Position position = await determinePosition();

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];
      return "${place.locality}, ${place.country}";
    } catch (e) {
      return "Failed to get address";
    }
  }

  Future<List<Map<String, dynamic>>> searchCities(String query) async {
    final response = await http.get(Uri.parse(
        'http://localhost:8080/api/locations/search?cityName=$query'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print("Cities data: $data"); // Dodano za ispis rezultata
      return data.map((city) => city as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load cities');
    }
  }
}
