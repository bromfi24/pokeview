import 'package:flutter/material.dart';
import 'package:pokeview/presentation/common/resources/constants.dart';
import 'package:pokeview/presentation/view/auth/welcome.dart';
import 'package:pokeview/presentation/common/resources/background_gradient.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const routeName = 'main-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(colorsList: Constants.colorsListScreen,child: WelcomeScreen()),
    );
  }
}
