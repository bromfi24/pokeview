import 'package:flutter/material.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/presentation/providers/pokemons_provider.dart';
import 'package:pokeview/presentation/screens/widgets/progress/poke_spin.dart';
import 'package:pokeview/presentation/screens/widgets/views/pokemon_detail_move.dart';
import 'package:provider/provider.dart';

class PokemonMovesWidget extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonMovesWidget({super.key, required this.pokemon});

  @override
  State<PokemonMovesWidget> createState() => _PokemonMovesWidgetState();
}

class _PokemonMovesWidgetState extends State<PokemonMovesWidget> {
  late Pokemon _pokemon; // Variable para almacenar el Pokémon con sus movimientos
  bool _isLoading = true; // Para controlar el estado de carga
  bool isMounted = true;

  //TODO: Comprobar si esta montado el widget

  @override
  void initState() {
    super.initState();
    // Inicialmente, usamos el Pokémon recibido
    _loadMoves(); // Cargar movimientos de forma asíncrona
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  Future<void> _loadMoves() async {
    if (!isMounted) return;
    final discoverProvider = context.read<PokemonsProvider>();
     // Esperamos la carga de movimientos
    _pokemon = await discoverProvider.getPokemonMoves(widget.pokemon);
    setState((){
      _isLoading = false; // Cambiamos el estado cuando los movimientos se han cargado
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? PokeSpin(width: 50, height: 50, infinite: true) // Indicador de carga
        : SizedBox(
          height: 90,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _pokemon.moves.length,
            itemBuilder: (context, index) {
              final move = _pokemon.moves[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: PokemonMoveCard(
                  moveName: move.name,
                  moveType: move.type,
                ),
              );
            },
          ),
        );
  }
}
