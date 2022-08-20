import 'package:final_project/src/screens/home.dart';
import 'package:final_project/src/screens/login.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.cyan[800],
        accentColor: Colors.cyan[300],
      ),
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/home": (context) => const HomeScreen(),
        "/": (context) => const LoginScreen(),
        "/register": (context) => const LoginScreen()
      },
    );
  }
}
