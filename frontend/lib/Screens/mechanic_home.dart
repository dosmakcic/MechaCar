import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class MechanicHome extends StatefulWidget {
  const MechanicHome({super.key});

  @override
  State<MechanicHome> createState() => _MechanicHomeState();
}

class _MechanicHomeState extends State<MechanicHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Početna mehanicar '),
      ),
      body: Center(child: Card()),
    );
  }
}
