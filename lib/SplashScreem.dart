import 'package:flutter/material.dart';
import 'iniciar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    // Crea una animación de escala (zoom) que va desde 0.5 a 1.0
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Inicia la animación cuando el Widget se construye
    _animationController.forward();

    // Redirigir a la siguiente pantalla (por ejemplo, HomeScreen) al finalizar la animación
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => RegistroTelefonoScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Cambia el color de fondo a negro
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value, // Aplica la escala según la animación
              child: child,
            );
          },
          child: Image.asset(
            'assets/img/logo1.png',
            width: 200.0,
            height: 200.0,
          ),
        ),
      ),
    );
  }
}
