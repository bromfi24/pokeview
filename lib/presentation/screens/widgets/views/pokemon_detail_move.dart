import 'package:flutter/material.dart';
import 'package:pokeview/config/constants/constants.dart';

class PokemonMoveCard extends StatelessWidget {
  final String moveName;
  final String moveType;

  const PokemonMoveCard({
    super.key,
    required this.moveName,
    required this.moveType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 230, 229, 229),
        border: Border.all(color: Colors.black, width: 2), // Marco individual
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            moveName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: '8bits',
              color: Colors.black,
            ),
          ),
          Image.asset(
            'assets/images/pokemon_types/$moveType.png',
            width: 40,
            height: 40,
          ),
        ],
      )
    );
  }
}
