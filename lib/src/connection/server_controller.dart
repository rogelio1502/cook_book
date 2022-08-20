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
}
