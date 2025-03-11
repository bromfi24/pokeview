import 'package:flutter/material.dart';
import 'package:pokeview/presentation/common/resources/responsive.dart';
import 'package:pokeview/presentation/common/widget/buttons/poke_button.dart';
import 'package:pokeview/presentation/navigation/navigation_routes.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(responsive.widthPercent(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 1),
                child: Text(
                  'PokeView',
                  style: TextStyle(
                    fontSize: responsive.widthPercent(15),
                    fontFamily: 'PokemonFont',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: responsive.heightPercent(5)),
              AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 2),
                child: PokeButton(
                  onTap: () {
                    context.go(NavigationRoutes.listRoute);
                  },
                ),
              ),
              SizedBox(height: responsive.heightPercent(2)),
              AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 2),
                child: Text(
                  'Pulsa en la pokeball para continuar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.widthPercent(6),
                    fontFamily: 'PokemonFont',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

