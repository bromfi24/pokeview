import 'package:flutter/material.dart';

class PokeButton extends StatelessWidget {
  final VoidCallback onTap; // Recibe una función sin parámetros

  const PokeButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Ejecuta la función pasada por parámetro
      child: ClipOval(
        child: Container(
          width: 150, 
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/pokeball.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
