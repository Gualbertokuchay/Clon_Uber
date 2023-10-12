import 'package:flutter/material.dart';

class PlanificarViajeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planifica tu Viaje'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Título "Planifica tu Viaje"

            SizedBox(height: 15.0),

            // Cuadros "Iniciar el Viaje Ahora" y "Para Mí"
            Row(
              children: [
                Expanded(
                  child: _buildCuadroConIconos(
                    'Iniciar el Viaje Ahora',
                    Icons.access_time, // Icono de reloj
                    Icons.arrow_drop_down, // Icono de flecha hacia abajo
                  ),
                ),
                SizedBox(width: 4.0), // Espacio más pequeño entre los cuadros
                Expanded(
                  child: _buildCuadroConIconos(
                    'Para Mí',
                    Icons.person, // Icono de usuario
                    Icons.arrow_drop_down, // Icono de flecha hacia abajo
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.0), // Espacio más grande entre los cuadros

            // Cuadros de texto "Lugar actual" y "¿A dónde vas?"
            _buildCuadroDeTexto('Lugar actual'),
            SizedBox(
                height: 4.0), // Espacio más pequeño entre los cuadros de texto
            _buildCuadroDeTexto('¿A dónde vas?'),
          ],
        ),
      ),
    );
  }

  Widget _buildCuadroConIconos(String texto, IconData icono1, IconData icono2) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Icon(icono1),
          ),
          Expanded(
            child: Text(
              texto,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Icon(icono2),
          ),
        ],
      ),
    );
  }

  Widget _buildCuadroDeTexto(String hintText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
        ),
      ),
    );
  }
}
