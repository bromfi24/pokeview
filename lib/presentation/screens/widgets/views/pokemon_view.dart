import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                pokemon.imagesUrl[0],
                width: 100, // Tamaño más grande de la imagen
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16), // Espaciado entre imagen y texto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'ID: ${pokemon.id}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    'Types: ${pokemon.types.join(' - ')}',
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
