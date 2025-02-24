import 'package:flutter/material.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/presentation/providers/pokemons_provider.dart';
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
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Indicador de carga
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _pokemon.moves.length,
              itemBuilder: (context, index) {
                final move = _pokemon.moves[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            move.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            move.type,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
