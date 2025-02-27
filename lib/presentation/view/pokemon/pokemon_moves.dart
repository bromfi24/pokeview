import 'package:flutter/material.dart';
import 'package:pokeview/core/di/app_modules.dart';
import 'package:pokeview/model/pokemon.dart';
import 'package:pokeview/presentation/common/base/resource_state.dart';
import 'package:pokeview/presentation/common/widget/error/error_overlay.dart';
import 'package:pokeview/presentation/common/widget/loading/loading_overlay.dart';
import 'package:pokeview/presentation/view/pokemon/detail_move.dart';
import 'package:pokeview/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';

class PokemonMovesWidget extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonMovesWidget({super.key, required this.pokemon});

  @override
  State<PokemonMovesWidget> createState() => _PokemonMovesWidgetState();
}

class _PokemonMovesWidgetState extends State<PokemonMovesWidget> {
  late Pokemon _pokemon;
  bool _isLoading = true; // Controla si la carga está en curso
  bool isMounted = true;
  final _pokemonViewModel = inject<PokemonViewModel>();

  @override
  void initState() {
    super.initState();
    _pokemon = widget.pokemon;

    _pokemonViewModel.pokemonListState.stream.listen((state) {
      if (!isMounted) return; // Evitar actualizaciones si el widget está desmontado

      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context, Alignment.center);
          break;
        case Status.SUCCESS:
          LoadingOverlay.hide();
          setState(() {
            _pokemon = state.data as Pokemon; // Asumimos que state.data es un Pokemon
            _isLoading = false;
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error);
          setState(() {
            _isLoading = false; // Permitir manejar el error en build si deseas
          });
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });

    _pokemonViewModel.getPokemonMoves(_pokemon);
  }

  @override
  void dispose() {
    isMounted = false;
    LoadingOverlay.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Mientras está cargando, no renderizamos el ListView
      return const SizedBox.shrink(); // Widget vacío mientras carga
    }

    // Solo renderizamos cuando la carga ha terminado con éxito
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (_pokemon.moves.length / 2).ceil(),
        itemBuilder: (context, index) {
          final move_1 = _pokemon.moves[index * 2];
          final move_2 = (index * 2 + 1) < _pokemon.moves.length
              ? _pokemon.moves[index * 2 + 1]
              : null;

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
                const SizedBox(height: 10),
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