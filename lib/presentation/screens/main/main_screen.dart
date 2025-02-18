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
        child: SurveyScreen()
      )
    );
  }
}