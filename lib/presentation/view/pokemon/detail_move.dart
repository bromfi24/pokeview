import 'package:flutter/material.dart';
import 'package:pokeview/presentation/common/resources/constants.dart';
import 'package:pokeview/presentation/common/resources/responsive.dart'; // Importa la clase Responsive

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
    final responsive = Responsive.of(context); // Inicializamos responsive
    return Container(
      width: responsive.widthPercent(37), 
      height: responsive.heightPercent(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 230, 229, 229),
        border: Border.all(color: Colors.black, width: 2), // Marco individual
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centrado vertical
        children: [
          Text(
            moveName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: responsive.widthPercent(5), // Tamaño de fuente dinámico
              fontFamily: '8bits',
              color: Colors.black,
            ),
          ),
          // Usamos un Align para asegurar que la imagen no se desborde
          Image.asset(
            '${Constants.ROUTE_ASSETS_TYPE}$moveType.png',
            width: responsive.widthPercent(10), // Tamaño de la imagen dinámico
            height: responsive.heightPercent(5), // Tamaño ajustado
          ),
        ],
      ),
    );
  }
}
