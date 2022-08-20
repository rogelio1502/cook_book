import 'package:flutter/material.dart';

Widget getDrawer(BuildContext context, String username) {
  return Drawer(
    child: ListView(children: [
      DrawerHeader(
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(
          child: Container(
            child: Text(
              username.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
      ListTile(
        title: const Text('Cerrar Sesión'),
        leading: const Icon(Icons.logout),
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/');
        },
      )
    ]),
  );
}
