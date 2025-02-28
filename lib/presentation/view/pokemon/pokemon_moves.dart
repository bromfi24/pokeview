import 'package:flutter/material.dart';
import 'package:pokeview/core/di/app_modules.dart';
import 'package:pokeview/model/pokemon.dart';
import 'package:pokeview/presentation/common/base/resource_state.dart';
import 'package:pokeview/presentation/common/widget/error/error_overlay.dart';
import 'package:pokeview/presentation/common/widget/loading/loading_overlay.dart';
import 'package:pokeview/presentation/view/pokemon/detail_move.dart';
import 'package:pokeview/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';
import 'package:pokeview/presentation/common/resources/responsive.dart'; // Importamos la clase Responsive

class PokemonMovesWidget extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonMovesWidget({super.key, required this.pokemon});

  @override
  State<PokemonMovesWidget> createState() => _PokemonMovesWidgetState();
}

class _PokemonMovesWidgetState extends State<PokemonMovesWidget> {
  late Pokemon _pokemon;
  bool _isLoading = true;
  bool isMounted = true;
  final _pokemonViewModel = inject<PokemonViewModel>();

  @override
  void initState() {
    super.initState();
    _pokemon = widget.pokemon;

    _pokemonViewModel.pokemonListState.stream.listen((state) {
      if (!isMounted) return;

      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context, Alignment.center);
          break;
        case Status.SUCCESS:
          LoadingOverlay.hide();
          setState(() {
            _pokemon = state.data as Pokemon;
            _isLoading = false;
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error);
          setState(() {
            _isLoading = false;
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
    final responsive = Responsive.of(context); // Inicializamos la clase Responsive

    if (_isLoading) {
      return const SizedBox.shrink(); // Mientras se carga, no mostramos nada
    }

    return SizedBox(
      height: responsive.heightPercent(40), // Ajustamos el tamaño según el alto de la pantalla
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (_pokemon.moves.length / 2).ceil(),
        itemBuilder: (context, index) {
          final move_1 = _pokemon.moves[index * 2];
          final move_2 = (index * 2 + 1) < _pokemon.moves.length
              ? _pokemon.moves[index * 2 + 1]
              : null;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.widthPercent(2), // Ajustamos el espaciado horizontal
            ),
            child: Column(
              children: [
                PokemonMoveCard(
                  moveName: move_1.name,
                  moveType: move_1.type,
                ),
                if (move_2 != null) ...[
                  SizedBox(height: responsive.heightPercent(1)), // Ajustamos el espacio entre las tarjetas
                  PokemonMoveCard(
                    moveName: move_2.name,
                    moveType: move_2.type,
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
