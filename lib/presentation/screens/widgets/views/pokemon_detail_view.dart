import 'package:flutter/material.dart';
import 'package:pokeview/config/constants/constants.dart';
import 'package:pokeview/domain/entities/pokemon.dart';

class PokemonDetailView extends StatelessWidget {
  const PokemonDetailView({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: 400,
          height: 700,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 3.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: PokemonDetailInfo(pokemon: pokemon),
        ),
      ),
    );
  }
}

class PokemonDetailInfo extends StatelessWidget {
  const PokemonDetailInfo({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: pokemon.imagesUrl.map((imageUrl) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Image.network(imageUrl, width: 100, height: 100),
          )).toList(),
        ),
        const SizedBox(height: 20),
        Text(
          'Height: ${pokemon.height} m', 
            style: TextStyle(fontSize: 30, 
              fontWeight: FontWeight.bold,
              fontFamily: "8bits",
          ),
        ),
        Text(
          'Weight: ${pokemon.weight} kg', 
            style: TextStyle(fontSize: 30, 
              fontWeight: FontWeight.bold,
              fontFamily: "8bits",
          ),
        ),
        Text(
          'Base XP: ${pokemon.height}', 
            style: TextStyle(fontSize: 30, 
              fontWeight: FontWeight.bold,
              fontFamily: "8bits",
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: pokemon.types.map((type) {
            // Construir la ruta de la imagen para cada tipo
            String imagePath = '${Constants.ROUTE_ASSETS_TYPE}$type.png';
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                imagePath,
                width: 50, // Ajusta el tamaño de las imágenes
                height: 50, // Ajusta el tamaño de las imágenes
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}