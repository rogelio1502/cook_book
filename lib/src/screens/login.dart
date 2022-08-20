import 'package:final_project/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

class LoginScreen extends StatefulWidget {
  ServerController _serverController;
  BuildContext context;

  LoginScreen(this._serverController, this.context, {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  bool _unauthorized = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 100),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.cyan,
                Colors.black,
              ]),
            ),
            height: 350,
            child: Image.asset(
              'assets/logo.png',
              color: Colors.white,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 80),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.only(
                      top: 20, right: 20, left: 20, bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration:
                              const InputDecoration(label: Text('Usuario:')),
                          obscureText: true,
                          onSaved: (newValue) {
                            username = newValue.toString();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Dato requerido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(label: Text('Contaseña:')),
                          obscureText: true,
                          onSaved: (newValue) {
                            password = newValue.toString();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Dato requerido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          onPressed: () {
                            _login(context);
                          },
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Iniciar Sesión'),
                                if (_loading)
                                  Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (_unauthorized)
                          const Center(
                            child: Text(
                              'Credenciales incorrectas',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('No estas registrado?'),
                            FlatButton(
                              textColor: Theme.of(context).primaryColor,
                              onPressed: () {
                                _showRegister(context);
                              },
                              child: const Text('Registrate'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  void _login(BuildContext context) async {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
      if (_formKey.currentState!.validate()) {
        setState(() {
          _unauthorized = false;
        });
        _formKey.currentState!.save();
        User user = await widget._serverController.login(username, password);

        if (user == null) {
          setState(() {
            _loading = false;
            _unauthorized = true;
          });
        } else {
          Navigator.of(context).pushReplacementNamed('/home', arguments: user);
        }
      }
    }
  }

  void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/register');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._serverController.init(widget.context);
  }
}
