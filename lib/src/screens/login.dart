import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Usuario:')),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Contaseña:')),
                        obscureText: true,
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
    );
  }

  void _login(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/register');
  }
}
