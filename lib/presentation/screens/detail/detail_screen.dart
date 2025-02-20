import 'package:flutter/material.dart';
import 'package:pokeview/config/constants/constants.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/presentation/screens/widgets/shared/background_gradient.dart';
import 'package:pokeview/presentation/screens/widgets/shared/custom_app_bar.dart';
import 'package:pokeview/presentation/screens/widgets/views/pokemon_detail_view.dart';

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