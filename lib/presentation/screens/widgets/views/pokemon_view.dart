import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeview/config/constants/constants.dart';
import 'package:pokeview/domain/entities/pokemon.dart';

class PokemonView extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonView({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/detail', extra: pokemon);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [// Espaciado entre imagen y texto
            Expanded(
              child: PokemonInfo(pokemon: pokemon),
            ),
                        Image.network(
              pokemon.imagesUrl[0],
              width: 100, // Tamaño más grande de la imagen
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16), 
          ],
        ),
      ),
    );
  }
}

class PokemonInfo extends StatelessWidget {
  const PokemonInfo({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          pokemon.id.toString(),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "8bits",
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Para que la columna solo ocupe lo necesario
            crossAxisAlignment: CrossAxisAlignment.center, // Centra el contenido
            children: [
              Text(
                pokemon.name,
                textAlign: TextAlign.center, // Centra el texto
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: "8bits",
                ),
              ),
              const SizedBox(height: 8), // Espacio entre el nombre y los tipos
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centra los tipos
                children: pokemon.types.map((type) {
                  // Construir la ruta de la imagen para cada tipo
                  String imagePath = '${Constants.ROUTE_ASSETS_TYPE}$type.png';
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Image.asset(
                      imagePath,
                      width: 50, // Ajusta el tamaño de las imágenes
                      height: 50, // Ajusta el tamaño de las imágenes
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
