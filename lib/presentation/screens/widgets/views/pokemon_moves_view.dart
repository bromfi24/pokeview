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

    final discoverProvider = context.read<PokemonsProvider>();

    _pokemon = await discoverProvider.getPokemonMoves(widget.pokemon);

    if (!isMounted) return;
    setState((){
      _isLoading = false; // Cambiamos el estado cuando los movimientos se han cargado
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
    ? PokeSpin(width: 50, height: 50, infinite: true) // Indicador de carga
    : SizedBox(
        height: 200,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: (_pokemon.moves.length / 2).ceil(), // Asegúrate de contar la mitad, redondeando hacia arriba
          itemBuilder: (context, index) {
            final move_1 = _pokemon.moves[index * 2]; // Primer movimiento
            final move_2 = (index * 2 + 1) < _pokemon.moves.length
                ? _pokemon.moves[index * 2 + 1] // Segundo movimiento, solo si existe
                : null; // Si no hay segundo movimiento, se asigna null
                
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: PokemonMoveCard(
                    moveName: move_1.name,
                    moveType: move_1.type,
                  ),
                ),
                if (move_2 != null) ...[
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: PokemonMoveCard(
                      moveName: move_2.name,
                      moveType: move_2.type,
                    ),
                  ),
                ]
              ],
            );
          },
        ),
      );
  }
}
