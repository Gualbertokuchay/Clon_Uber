import 'package:flutter/material.dart';
import 'Home.dart'; // Importa la vista UberHomeScreen
import 'formulario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegistroTelefonoScreen extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Ingresar número de teléfono móvil',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  // Cuadro de selección de país
                  Container(
                    width: 80.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Container(
                            width: 44.0,
                            height: 24.0,
                            child: Image.asset(
                              'assets/img/mexico.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  // Cuadro de entrada de número de teléfono con navegación a UberHomeScreen
                  Expanded(
                    child: TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      textInputAction:
                          TextInputAction.done, // Cambia el teclado a "Done"
                      onFieldSubmitted: (_) {
                        // Redirige a la vista UberHomeScreen cuando se presiona "Enter"
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => UberHomeScreen()),
                        );
                      },
                      decoration: InputDecoration(
                        labelText: 'Número de teléfono',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              DividerWithText(text: 'o'),
              SizedBox(height: 20.0),
              Text(
                'Continuar con:',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 10.0),
              // Botón "Continuar con Google" con navegación a UberHomeScreen
              InkWell(
                onTap: () async {
                  try {
                    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
                    final AuthCredential credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );

                    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                    final User? user = userCredential.user;

                    if (user != null) {
                      // La autenticación con Google fue exitosa, redirige al usuario a la siguiente pantalla.
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => UberHomeScreen()),
                      );
                    }
                  } catch (e) {
                    // Maneja cualquier error que pueda ocurrir durante la autenticación con Google.
                    print('Error en la autenticación con Google: $e');
                  }
                },
                child: _buildContinuarButton(
                    'Continuar con Google', Icons.mail_lock_outlined),
              ),
              SizedBox(height: 10.0),
              _buildContinuarButton('Continuar con Apple', Icons.apple),
              SizedBox(height: 10.0),
              _buildContinuarButton('Continuar con Facebook', Icons.facebook),
              SizedBox(height: 10.0),
              _buildContinuarButton(
                  'Continuar con Correo Electrónico', Icons.email),
              SizedBox(height: 20.0), // Espacio entre los botones
              // Botón "Regístrate"
              ElevatedButton(
                onPressed: () {
                  // Navega a la vista de inicio de sesión (UberHomeScreen)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Registro()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Cambia el color de fondo del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Regístrate',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white, // Cambia el color del texto
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinuarButton(String text, IconData icon) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 20.0),
          Icon(icon),
          SizedBox(width: 20.0),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class DividerWithText extends StatelessWidget {
  final String text;

  DividerWithText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(text),
        ),
        Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}
