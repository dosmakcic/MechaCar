import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = '';

  void _onSearchChanged(String value) {
    setState(() {
      city = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pretraži Mehaničare '),
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
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(city),
                          SizedBox(width: 8),
                          Text('Cijena: 2000'),
                          SizedBox(width: 8),
                          Text('Datum: 10.06.2022'),
                          ElevatedButton(
                            onPressed: () {
                              // Ovdje možete dodati funkcionalnost za prihvaćanje
                            },
                            child: Text('Prihvati'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              // Ovdje možete dodati funkcionalnost za odbijanje
                            },
                            child: Text('Odbij'),
                          ),
                        ],
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
