import 'package:flutter/material.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/presentation/screens/widgets/shared/custom_app_bar.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = 'detail-screen';
  final Pokemon pokemon;
  const DetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: pokemon.name),
      body: PokemonDetail(pokemon: pokemon),  
    );
  }
}

class PokemonDetail extends StatelessWidget {
  const PokemonDetail({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(pokemon.imagesUrl[0]),
          Image.network(pokemon.imagesUrl[1]),
          Image.network(pokemon.imagesUrl[2]),
          Text(pokemon.name),
          Text(pokemon.height.toString()),
          Text(pokemon.weight.toString()),
          Text(pokemon.baseXP.toString()),
          Text(pokemon.types.join('-')),
        ],
      ),
    );
  }
}