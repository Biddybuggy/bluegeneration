import 'package:bluegeneration/donation/camera_screen.dart';
import 'package:bluegeneration/donation/confirmation_screen.dart';
import 'package:bluegeneration/donation/steps_screen.dart';
import 'package:flutter/material.dart';
import 'package:bluegeneration/register/register_screen.dart';

import '../login/login_screen.dart';
import '../home/home_screen.dart';
import '../main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ConfirmationScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ConfirmationScreen(),);
      case CameraScreen.routeName:
        return MaterialPageRoute(
          builder:(context) => CameraScreen(cameras: cameras),
        );
      case StepsScreen.routeName:
        return MaterialPageRoute(
          builder:(context) => const StepsScreen(),
        );
      case HomeScreen.routeName:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder:(context) => HomeScreen(username:args as String),
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