import 'package:flutter/material.dart';
import 'Home.dart';
import 'Historial.dart';
import 'perfil.dart';

class MyNavBar extends StatefulWidget {
  @override
  _MyNavBarState createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.home,
    Icons.calendar_month_outlined,
    Icons.person,
  ];

  final List<String> _labels = ['Inicio', 'Historial', 'Perfil'];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      selectedItemColor: const Color.fromARGB(255, 12, 12, 12),
      unselectedItemColor: Colors.black.withOpacity(
          0.6), // Color de los iconos no seleccionados (opacidad reducida)
      items: List.generate(_icons.length, (index) {
        final isSelected = index == _selectedIndex;

        return BottomNavigationBarItem(
          icon: Icon(
            _icons[index],
            color: isSelected
                ? const Color.fromARGB(255, 25, 25, 26)
                : const Color.fromARGB(255, 179, 179, 179).withOpacity(
                    0.6), // Si está seleccionado, usa el color azul; de lo contrario, usa negro con opacidad reducida
          ),
          label: _labels[index],
        );
      }),
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });

        // Navegar a la pantalla correspondiente según el índice seleccionado
        switch (index) {
          case 0:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => UberHomeScreen(),
              ),
            );
            break;
          case 1:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => HistorialViajesScreen(),
              ),
            );
            break;
          case 2:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => ProfileScreen(),
              ),
            );
            break;
        }
      },
    );
  }
}
