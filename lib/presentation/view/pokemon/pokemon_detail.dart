import 'package:flutter/material.dart';
import 'package:pokeview/core/di/app_modules.dart';
import 'package:pokeview/presentation/common/base/resource_state.dart';
import 'package:pokeview/presentation/common/resources/constants.dart';
import 'package:pokeview/presentation/common/resources/responsive.dart';
import 'package:pokeview/presentation/common/resources/shadowed_image.dart';
import 'package:pokeview/model/pokemon.dart';
import 'package:pokeview/presentation/common/widget/error/error_overlay.dart';
import 'package:pokeview/presentation/common/widget/loading/loading_overlay.dart';
import 'package:pokeview/presentation/view/pokemon/pokemon_moves.dart';
import 'package:pokeview/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';

class PokemonDetailView extends StatefulWidget {
  const PokemonDetailView({
    super.key,
    required this.pokemon,
    required this.onDelete,
  });

  final Pokemon pokemon;
  final void Function() onDelete;

  @override
  State<PokemonDetailView> createState() => _PokemonDetailViewState();
}

class _PokemonDetailViewState extends State<PokemonDetailView> {

  final _pokemonViewModel = inject<PokemonViewModel>();
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    _pokemonViewModel.pokemonListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          //LoadingOverlay.show(context, Alignment.center);
          break;
        case Status.SUCCESS:
          //LoadingOverlay.hide();
          setState(() {
            isFavorite = state.data;
          });
          break;
        case Status.ERROR:
          //LoadingOverlay.hide();
          //ErrorOverlay.of(context).show(state.error);
          break;
        default:
          //LoadingOverlay.hide();
          break;
      }
    });
    _pokemonViewModel.isPokemonFavorite(widget.pokemon);
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: Responsive.of(context).widthPercent(90),
          height: Responsive.of(context).heightPercent(80),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 3.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: PokemonDetailInfo(pokemon: widget.pokemon, isFavorite:isFavorite, onDelete: widget.onDelete,),
        ),
      ),
    );
  }
}

class PokemonDetailInfo extends StatefulWidget {
  const PokemonDetailInfo({
    super.key,
    required this.pokemon,
    required this.isFavorite,
    required this.onDelete,
  });

  final Pokemon pokemon;
  final bool isFavorite;
  final void Function() onDelete;

  @override
  State<PokemonDetailInfo> createState() => _PokemonDetailInfoState();
}

class _PokemonDetailInfoState extends State<PokemonDetailInfo> {
  final _pokemonViewModel = inject<PokemonViewModel>();

  late bool isFavorite = widget.isFavorite; 
  
  @override
  void didUpdateWidget(PokemonDetailInfo oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Verifica si el valor de isFavorite ha cambiado
    if (oldWidget.isFavorite != widget.isFavorite) {
      setState(() {
        isFavorite = widget.isFavorite;
      });
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.start, // Alinea los elementos arriba
        crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
        children: [
          // IMÁGENES ARRIBA
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.pokemon.imagesUrl
                .map((imageUrl) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ShadowedImage(
                          imageUrl: imageUrl,
                          width: 90,
                          height: 90,
                          shadowColor:
                              Constants.typeColors[widget.pokemon.types[0]] ??
                                  Colors.white),
                    ))
                .toList(),
          ),
          const SizedBox(height: 35),
          // ALTURA
          Text(
            'Height: ${widget.pokemon.height} m',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: "8bits",
            ),
          ),

          // PESO
          Text(
            'Weight: ${widget.pokemon.weight} kg',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: "8bits",
            ),
          ),

          // BASE XP 
          Text(
            'Base XP: ${widget.pokemon.baseXP}',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: "8bits",
            ),
          ),
          // TIPOS DE POKÉMON
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.pokemon.types.map((type) {
              String imagePath = '${Constants.ROUTE_ASSETS_TYPE}$type.png';
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  imagePath,
                  width: 50,
                  height: 50,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          //MOVIMIENTOS DE POKEMON
          PokemonMovesWidget(pokemon: widget.pokemon),
          // BOTÓN DE FAVORITOS
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                if (!isFavorite) {
                  _pokemonViewModel.savePokemon(widget.pokemon);
                } else {
                  _pokemonViewModel.deletePokemon(widget.pokemon);
                  widget.onDelete();
                }
                isFavorite = !isFavorite;
              });
            },
            child: Column(
              children: [
                Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                  size: 50,
                ),
                const SizedBox(height: 5),
                Text(
                  isFavorite
                      ? "¡Este Pokemon ya es tu favorito!"
                      : "Guardalo como favorito",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "8bits",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
