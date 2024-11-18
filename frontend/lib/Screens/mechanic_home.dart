import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MechanicHome extends StatefulWidget {
  const MechanicHome({super.key});

  @override
  State<MechanicHome> createState() => _MechanicHomeState();
}

class _MechanicHomeState extends State<MechanicHome> {
  late int userId;
  late String userName;
  Map<String, dynamic>? mechanicData;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Preuzimanje argumenata prosleđenih iz login-a
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Osiguravamo da su id i name prisutni u argumentima
    userId = args['id'] ?? 0; // Ako nema id, postavljamo na 0
    userName = args['name'] ??
        'Početna'; // Ako nema name, postavljamo default vrednost

    fetchMechanicData();
  }

  Future<void> fetchMechanicData() async {
    final url = Uri.parse('http://localhost:8080/mechanics/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          mechanicData = json.decode(response.body);
          userName = mechanicData!['name'] ??
              'Početna'; // Ako nema imena u odgovoru, postavljamo default
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load mechanic data');
      }
    } catch (error) {
      setState(() {
        isLoading =
            false; // Kada se završi učitavanje, postavimo isLoading na false
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Failed to load mechanic data. Please try again later.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Welcome $userName'), // Direktno koristimo userName jer je on već dodeljen
      ),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Prikazujemo indikator učitavanja dok čekamo podatke
          : Center(
              child: Text('Lista mehanicara '), // Prikazujemo ime mehaničara
            ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, '/login'); // Navigacija na login ekran
          },
          child: Icon(Icons.logout),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
