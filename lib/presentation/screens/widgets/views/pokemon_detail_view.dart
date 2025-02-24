import 'package:flutter/material.dart';
import 'package:pokeview/config/constants/constants.dart';
import 'package:pokeview/config/styles/shadowed_image.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/presentation/screens/widgets/views/pokemon_moves_view.dart';

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
          width: 440,
          height: 720,
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
      return SizedBox.expand( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Alinea los elementos arriba
          crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
          children: [
            // IMÁGENES ARRIBA
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.imagesUrl.map((imageUrl) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ShadowedImage(imageUrl: imageUrl, width: 90, height: 90, shadowColor: Constants.typeColors[pokemon.types[0]] ?? Colors.white),
              )).toList(),
            ),
            const SizedBox(height: 35),
            // ALTURA
            Text(
              'Height: ${pokemon.height} m',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "8bits",
              ),
            ),

            // PESO
            Text(
              'Weight: ${pokemon.weight} kg',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "8bits",
              ),
            ),

            // BASE XP (CORRECCIÓN: Debía ser pokemon.baseExperience en vez de height)
            Text(
              'Base XP: ${pokemon.baseXP}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "8bits",
              ),
            ),
            // TIPOS DE POKÉMON
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.types.map((type) {
                String imagePath = '${Constants.ROUTE_ASSETS_TYPE}$type.png';
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    imagePath,
                    width: 50,
                    height: 50,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            //MOVIMIENTOS DE POKEMON
            PokemonMovesWidget(pokemon:pokemon),
          ],
        ),
      );
    }
}