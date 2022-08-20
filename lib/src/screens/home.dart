import 'package:final_project/src/components/drawer/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

class HomeScreen extends StatefulWidget {
  final User loggedUser;
  const HomeScreen(this.loggedUser, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(children: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
          child: const Center(child: Text('Cerrar Sesión')),
        )
      ]),
      drawer: getDrawer(),
    );
  }
}
