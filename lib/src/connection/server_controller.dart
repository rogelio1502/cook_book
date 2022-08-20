import 'dart:io';

import 'package:flutter_modulo1_fake_backend/modulo1_fake_backend.dart'
    as server;
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter/widgets.dart';

class ServerController {
  // esto no se hace, solo ahora porque es fake
  void init(BuildContext context) {
    server.generateData(context);
  }

  Future<User> login(String username, String password) async {
    return await server.backendLogin(username, password);
  }

  Future<List<User>> getUsers() async {
    return await server.getUsers();
  }

  Future<bool> register(String username, String password, File? photo) async {
    User user;
    if (photo != null) {
      user = User(nickname: username, password: password, photo: photo);
    } else {
      user = User(nickname: username, password: password);
    }

    return await server.addUser(user);
  }
}
