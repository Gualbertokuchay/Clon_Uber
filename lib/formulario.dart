import 'package:flutter/material.dart';
import 'login.dart'; // Asegúrate de importar correctamente tu archivo de inicio de sesión
import 'package:firebase_auth/firebase_auth.dart';

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: unused_field
  String? _username;
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/img/logo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Usuario',
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
                  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu usuario';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value;
                  },
                ),
                SizedBox(height: 10),
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
                  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu correo electrónico';
                    }
                    // Agregar más validaciones de correo electrónico si es necesario
                    return null;
                  },
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                SizedBox(height: 10),
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
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                SizedBox(height: 10),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      registerUser();
                    }
                  },
                  child: Text(
                    'Registrarse',
                    style: TextStyle(color: Color.fromARGB(255, 241, 234, 234)),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    '¿Ya tienes una cuenta? Iniciar sesión',
                    style:
                        TextStyle(color: const Color.fromARGB(255, 36, 36, 36)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email!,
        password: _password!,
      );
      // Registro exitoso, hacer algo con userCredential si es necesario
      print('Registro exitoso: ${userCredential.user?.uid}');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            LoginScreen(), // Reemplaza la pantalla actual con LoginScreen
      ));
    } catch (e) {
      // Registro fallido, manejar el error
      print('Registro fallido: $e');
    }
  }
}
