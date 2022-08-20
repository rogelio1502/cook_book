import 'dart:io';

import 'package:final_project/src/components/image_picker.dart';
import 'package:final_project/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

class RegisterScreen extends StatefulWidget {
  ServerController _serverController;
  BuildContext context;

  RegisterScreen(this._serverController, this.context, {super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _loading = false;
  bool _error = false;
  File? imageFile;
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
              padding: const EdgeInsets.symmetric(vertical: 0),
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.cyan,
                  Colors.black,
                ]),
              ),
              height: 350,
              child: ImagePickerWidget(
                imageFile: imageFile,
                onImageSelected: (File file) {
                  setState(() {
                    imageFile = file;
                  });
                },
              )),
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
                          // obscureText: true,
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
                            _register(context);
                          },
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Registrarse'),
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
                        if (_error)
                          const Center(
                            child: Text(
                              'Credenciales incorrectas',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: kToolbarHeight + 25,
            child: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          )
        ]),
      ),
    );
  }

  void _register(BuildContext context) async {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        bool userAdded = await widget._serverController
            .register(username, password, imageFile!);
        print(userAdded);
        if (userAdded == false) {
          setState(() {
            _loading = false;
          });
        } else {
          Navigator.of(context).pop();
        }
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._serverController.init(widget.context);
  }
}
