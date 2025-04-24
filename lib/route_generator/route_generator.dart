import 'package:flutter/material.dart';
import 'package:bluegeneration/login-and-registration/register_screen.dart';

import '../login-and-registration/login_screen.dart';
import '../screens/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder:(context) => const HomeScreen(),
        );
      case RegisterScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) =>  const LoginScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Container(
            color: Colors.white,
            child: const Center(
              child: Text("Error, route not implemented."),
            ),
          ),
        );

    }
  }
}