import 'package:flutter/material.dart';
import 'package:pokeview/presentation/screens/main/survey_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const routeName = 'main-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Cierra el teclado cuando se toca cualquier lugar fuera de un campo de texto
          FocusScope.of(context).unfocus();
        },
          //TODO: Modularizar esto y sacarlo en una clase aparte
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topLeft,
                colors: [
                  Colors.red,
                  Colors.white,
                ],
              ),
            ),
            child: SurveyScreen(),
          ),
        ),
      );
  }
}
