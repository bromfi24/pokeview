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

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  double opacity = 0.0;
  late AnimationController _controller;
  late AnimationController _pokemonController;
  late Animation<double> _pokemonAnimation;

  @override
  void initState() {
    super.initState();

    // Iniciar animación de opacidad (fade-in)
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });

    // Animación de vibración de la Pokeball
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Animación de movimiento oscilante de los Pokémon
    _pokemonController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pokemonAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _pokemonController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pokemonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          // Título arriba
          SizedBox(height: responsive.heightPercent(8)),
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

          // Animación de Pokémon en el centro
          AnimatedBuilder(
            animation: _pokemonAnimation,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(0, _pokemonAnimation.value),
                    child: Image.asset('assets/images/starters_gen_1/starter_1.png', width: responsive.widthPercent(20)),
                  ),
                  SizedBox(width: responsive.widthPercent(5)),
                  Transform.translate(
                    offset: Offset(0, -_pokemonAnimation.value),
                    child: Image.asset('assets/images/starters_gen_1/starter_2.png', width: responsive.widthPercent(20)),
                  ),
                  SizedBox(width: responsive.widthPercent(5)),
                  Transform.translate(
                    offset: Offset(0, _pokemonAnimation.value),
                    child: Image.asset('assets/images/starters_gen_1/starter_3.png', width: responsive.widthPercent(20)),
                  ),
                ],
              );
            },
          ),

          SizedBox(height: responsive.heightPercent(2)),

          // Animación de vibración de la Pokéball
          RotationTransition(
            turns: Tween(begin: -0.02, end: 0.02).animate(_controller),
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 2),
              child: PokeButton(
                onTap: () {
                  context.go(NavigationRoutes.listRoute);
                },
              ),
            ),
          ),
          SizedBox(height: responsive.heightPercent(2)),

          // Texto de ayuda
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
          SizedBox(height: responsive.heightPercent(5)),
        ],
      ),
    );
  }
}
