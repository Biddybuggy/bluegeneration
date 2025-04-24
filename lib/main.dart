import 'package:flutter/material.dart';
import 'package:bluegeneration/route_generator/route_generator.dart';
import 'login-and-registration/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute:LoginScreen.routeName,debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}