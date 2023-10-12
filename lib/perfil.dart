import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text(
              'Nombre de Usuario',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Text('4.9'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTextBox(context, 'Izquierda', 'Información izquierda'),
              buildTextBox(context, 'Centro', 'Información centro'),
              buildTextBox(context, 'Derecha', 'Información derecha'),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            'Configuración',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          buildSettingItem(context, 'Notificaciones'),
          buildSettingItem(context, 'Privacidad'),
          buildSettingItem(context, 'Cuenta'),
          SizedBox(height: 20.0),
          Text(
            'Ayuda',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          buildSettingItem(context, 'Centro de ayuda'),
          buildSettingItem(context, 'Términos y condiciones'),
          buildSettingItem(context, 'Cerrar sesión'),
        ],
      ),
    );
  }

  Widget buildTextBox(BuildContext context, String title, String content) {
    return Expanded(
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 16.0),
        ),
        subtitle: Text(content),
      ),
    );
  }

  Widget buildSettingItem(BuildContext context, String title) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        if (title == 'Cerrar sesión') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Cerrar Sesión'),
                content: Text('¿Estás seguro de que deseas cerrar sesión?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Sí'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
  ));
}
