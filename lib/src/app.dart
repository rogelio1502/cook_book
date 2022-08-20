import 'package:final_project/src/connection/server_controller.dart';
import 'package:final_project/src/screens/home.dart';
import 'package:final_project/src/screens/login.dart';
import 'package:final_project/src/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

ServerController _serverController = ServerController();

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
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case '/':
              return LoginScreen(_serverController, context);
            case '/home':
              User userLogged = settings.arguments as User;
              return HomeScreen(userLogged);
            case '/register':
              return RegisterScreen(_serverController, context);
            default:
              return LoginScreen(_serverController, context);
          }
        });
      },
    );
  }
}
