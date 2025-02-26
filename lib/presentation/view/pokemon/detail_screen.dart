import 'package:flutter/material.dart';
import 'package:pokeview/presentation/common/resources/constants.dart';
import 'package:pokeview/model/pokemon.dart';
import 'package:pokeview/presentation/common/resources/background_gradient.dart';
import 'package:pokeview/presentation/common/widget/appbar/custom_app_bar.dart';
import 'package:pokeview/presentation/view/pokemon/pokemon_detail.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = 'detail-screen';
  final Pokemon pokemon;
  const DetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: pokemon.name),
      body: BackgroundGradient(colorsList: Constants.colorsDetailScreen, child: PokemonDetailView(pokemon: pokemon)),  
    );
  }
}