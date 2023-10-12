import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:uber/widgets/Maps.dart';
import 'Navigator.dart';

class Viaje {
  final String origen;
  final String destino;
  final String fecha;
  final String costo;

  Viaje({
    required this.origen,
    required this.destino,
    required this.fecha,
    required this.costo,
  });
}

class HistorialViajesScreen extends StatelessWidget {
  final List<Viaje> historialDeViajes = [
    Viaje(
      origen: 'Casa',
      destino: 'Trabajo',
      fecha: '15 de Septiembre, 2023',
      costo: '\$12.50',
    ),
    Viaje(
      origen: 'Tienda',
      destino: 'Gimnasio',
      fecha: '14 de Septiembre, 2023',
      costo: '\$8.75',
    ),
    Viaje(
      origen: 'Restaurante',
      destino: 'Cine',
      fecha: '13 de Septiembre, 2023',
      costo: '\$10.25',
    ),
    // Agrega más viajes según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actividad'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navega a la vista de inicio de sesión (UberHomeScreen)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => UberHomeScreen()),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: historialDeViajes.length + 1, // +1 para el resumen del viaje
        itemBuilder: (context, index) {
          if (index == 0) {
            // Mostrar el resumen del viaje en el primer ítem
            return _buildResumenViaje(context);
          } else {
            final viaje = historialDeViajes[index - 1];
            return _buildViajeCard(viaje, context);
          }
        },
      ),
      bottomNavigationBar: MyNavBar(), // Agregar el navegador aquí
    );
  }

  Widget _buildResumenViaje(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Fondo blanco
        border: Border.all(color: Colors.grey), // Contorno gris
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.black),
            title: Text(
              'Casa',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Trabajo',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.date_range, color: Colors.black),
            title: Text(
              'Fecha',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            subtitle: Text(
              '15 de Septiembre, 2023',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.attach_money, color: Colors.black),
            title: Text(
              'Costo',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            subtitle: Text(
              '\$12.50',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          // Espacio entre el resumen y los cuadros de texto
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navega a la página de inicio (Home)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MapSample()),
                  );
                },
                child: _buildCuadroRedondeado(
                    'Repetir Solicitud', Icons.keyboard_arrow_right_sharp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCuadroRedondeado(String texto, IconData icono) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Icon(icono),
          SizedBox(width: 8.0),
          Text(
            texto,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViajeCard(Viaje viaje, BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white, // Fondo blanco para las demás tarjetas
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.black),
            title: Text(
              viaje.origen,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              viaje.destino,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.date_range, color: Colors.black),
            title: Text(
              'Fecha',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            subtitle: Text(
              viaje.fecha,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.attach_money, color: Colors.black),
            title: Text(
              'Costo',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            subtitle: Text(
              viaje.costo,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
