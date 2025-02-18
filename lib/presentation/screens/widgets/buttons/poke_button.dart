import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PokeButton extends StatelessWidget {


  const PokeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/list');
      },
      child: ClipOval(
        child: Container(
          width: 150, // Tamaño del botón
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/pokeball.png'),
              fit: BoxFit.cover, // Ajuste de la imagen
            ),
          ),
        ),
      ),
    );
  }
}