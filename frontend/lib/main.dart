import 'package:flutter/material.dart';
import 'Screens/mechanic_home.dart';
import 'Screens/mechanic_register.dart';
import 'Screens/login_screen.dart';
import 'Screens/register_screen.dart';
import 'Screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    initialRoute: '/register_mechanic',
    routes: {
      '/login': (context) => LoginScreen(),
      '/register_driver': (context) => RegisterScreen(),
      '/register_mechanic': (context) => RegisterScreenMechanic(),
      '/driver_home': (context) => HomeScreen(),
      '/mechanic_home': (context) => MechanicHome()
    },
  ));
}
