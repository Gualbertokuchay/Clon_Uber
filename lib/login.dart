// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber/Home.dart';
import 'Navigator.dart';
import 'formulario.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _email;
  String? _password;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 80.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/img/logo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu correo electrónico';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu contraseña';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      try {
                        UserCredential userCredential =
                            await _auth.signInWithEmailAndPassword(
                          email: _email!,
                          password: _password!,
                        );
                        // Inicio de sesión exitoso, hacer algo con userCredential si es necesario
                        print(
                            'Inicio de sesión exitoso: ${userCredential.user?.uid}');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UberHomeScreen(),
                            ));
                      } on FirebaseAuthException catch (e) {
                        // Manejar errores de Firebase Auth
                        String errorMessage =
                            'Ocurrió un error al iniciar sesión.';

                        if (e.code == 'user-not-found') {
                          errorMessage = 'Usuario no encontrado.';
                        } else if (e.code == 'wrong-password') {
                          errorMessage = 'Contraseña incorrecta.';
                        }

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error al iniciar sesión'),
                              content: Text(errorMessage),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Aceptar'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Iniciar Sesión',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registro()),
                    );
                  },
                  child: Text(
                    '¿Aún no tienes una cuenta? Regístrate',
                    style:
                        TextStyle(color: const Color.fromARGB(255, 36, 36, 36)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyNavBar(),
    );
  }
}
