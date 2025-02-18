import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/presentation/providers/pokemons_provider.dart';
import 'package:pokeview/presentation/screens/list/pokemon_view.dart';
import 'package:pokeview/presentation/screens/widgets/shared/custom_app_bar.dart';
import 'package:provider/provider.dart';


class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  static const routeName = 'list-screen';

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    final discoverProvider = context.watch<PokemonsProvider>();
    return Scaffold(
      appBar: CustomAppBar(title: "Hazte con todos!"),
      body: PokemonVisualizer(discoverProvider: discoverProvider),
    );
  }
}

class PokemonVisualizer extends StatelessWidget {
  const PokemonVisualizer({
    super.key,
    required this.discoverProvider,
  });

  final PokemonsProvider discoverProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
    itemCount: discoverProvider.pokemons.length,
    itemBuilder: (context, index) {
      final pokemon = discoverProvider.pokemons[index];
      return PokemonView(pokemon: pokemon);
    },
    );
  }
}
