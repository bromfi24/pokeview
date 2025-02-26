import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;

  final List<Color> colorsList;

  const BackgroundGradient({super.key, required this.child,  required this.colorsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
          colors: colorsList
        ),
      ),
      child: child,
    );
  }
}
