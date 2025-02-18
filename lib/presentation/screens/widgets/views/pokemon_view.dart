import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeview/domain/entities/pokemon.dart';

class PokemonView extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonView({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
    onTap: () {
      context.push('/detail', extra: pokemon);
    },
    leading: Image.network(pokemon.imagesUrl[0]),
    title: Text(pokemon.name),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(pokemon.id.toString()),
        Text(pokemon.types.join(' - ')),
      ],
    ),
  );
  }
}