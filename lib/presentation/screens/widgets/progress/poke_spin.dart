import 'package:flutter/material.dart';

class PokeSpin extends StatefulWidget {
  const PokeSpin({super.key});

  @override
  PokeSpinState createState() => PokeSpinState();
}

class PokeSpinState extends State<PokeSpin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    // Inicializa el AnimationController con duración de 2 segundos
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(); // Repite la animación infinitamente

    // Define la animación de rotación (giro continuo)
    _rotation = Tween<double>(begin: 0.0, end: 6.28) // 6.28 radianes es una vuelta completa
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    // Libera el controlador de la animación cuando no se necesite más
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: RotationTransition(
        turns: _rotation,
        child: Image.asset(
          'assets/images/pokeball.png', // Ruta de la imagen
          width: 60, // Tamaño de la imagen
          height: 60, // Tamaño de la imagen
        ),
      ),
    );
  }
}
