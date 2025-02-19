import 'package:flutter/material.dart';
import 'package:pokeview/config/constants/constants.dart';
import 'package:pokeview/presentation/screens/main/survey_screen.dart';
import 'package:pokeview/presentation/screens/widgets/shared/background_gradient.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const routeName = 'main-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(colorsList: Constants.colorsMainScreen,child: SurveyScreen()),
    );
  }
}
