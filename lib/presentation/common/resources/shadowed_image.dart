import 'package:flutter/material.dart';

class ShadowedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final Color shadowColor;

  const ShadowedImage({
    super.key,
    required this.imageUrl,
    this.width = 100,
    this.height = 100,
    this.shadowColor =  Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color:shadowColor, // Color más suave
            blurRadius: 30, // Mayor difuminado
            spreadRadius: 2, // Más extensión
            offset: const Offset(0, 0), // Centrado
          ),
          BoxShadow(
            color: Colors.white, // Degradado hacia blanco
            blurRadius: 50,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
