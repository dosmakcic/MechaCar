import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = '';
  List<dynamic> allMechanics = [];
  List<dynamic> filteredMechanics = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllMechanics();
  }

  Future<void> fetchAllMechanics() async {
    final url = Uri.parse('http://localhost:8080/mechanics');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          allMechanics = data;
          filteredMechanics = data; // Prikazujemo sve mehaničare na početku
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch mechanics')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  void _onSearchChanged(String value) {
    setState(() {
      city = value.toLowerCase();
      filteredMechanics = allMechanics.where((mechanic) {
        final mechanicCity = mechanic['location']['city'].toLowerCase();
        return mechanicCity.contains(city);
      }).toList();
    });
  }

  Future<void> sendRequestToMechanic(int mechanicId) async {
    final url = Uri.parse('http://localhost:8080/requests');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'mechanicId': mechanicId,
          'driverId': 1, // Zamijenite stvarnim ID-jem vozača
        }),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request sent successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send request')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pretraži Mehaničare'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                labelText: 'Unesite grad',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredMechanics.isEmpty
                    ? Text('Nema dostupnih mehaničara za zadati grad.')
                    : Expanded(
                        child: ListView.builder(
                          itemCount: filteredMechanics.length,
                          itemBuilder: (context, index) {
                            final mechanic = filteredMechanics[index];
                            return Card(
                              child: ListTile(
                                title: Text(mechanic['name']),
                                subtitle: Text(
                                    'Grad: ${mechanic['location']['city']}'),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    sendRequestToMechanic(mechanic['id']);
                                  },
                                  child: Text('Pošalji zahtev'),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
