import 'package:flutter/material.dart';
import 'package:pokeview/presentation/providers/pokemons_provider.dart';
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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              discoverProvider.getNextPokemonsList();
            },
          ),
        ],
      ),
      body: ListView.builder(
      itemCount: discoverProvider.pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = discoverProvider.pokemons[index];
        return ListTile(
        title: Text(pokemon.name),
        subtitle: Text(pokemon.id.toString()),
        );
      },
      ),
    );
  }
}