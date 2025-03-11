import 'package:flutter/material.dart';
import 'package:pokeview/core/di/app_modules.dart';
import 'package:pokeview/data/remote/network_endpoints.dart';
import 'package:pokeview/presentation/common/base/resource_state.dart';
import 'package:pokeview/presentation/common/resources/constants.dart';
import 'package:pokeview/model/pokemon.dart';
import 'package:pokeview/presentation/common/widget/error/error_overlay.dart';
import 'package:pokeview/presentation/common/widget/loading/loading_overlay.dart';
import 'package:pokeview/presentation/common/resources/background_gradient.dart';
import 'package:pokeview/presentation/common/widget/appbar/search_app_bar.dart';
import 'package:pokeview/presentation/navigation/navigation_routes.dart';
import 'package:pokeview/presentation/view/pokemon/pokemon_view.dart';
import 'package:pokeview/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';
import 'package:pokeview/presentation/common/resources/responsive.dart'; // Importar la clase Responsive

class ListScreen extends StatefulWidget {
  const ListScreen({super.key, required this.isList});
  final bool isList;
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _pokemonViewModel = inject<PokemonViewModel>();
  late ScrollController _scrollController;
  bool isMounted = false;
  bool searchPressed = false;
  String query = '';
  List<Pokemon> pokemons = [];
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _pokemonViewModel.pokemonListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context, Alignment.center);
          break;
        case Status.SUCCESS:
          LoadingOverlay.hide();
          setState(() {
            pokemons = state.data;
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error);
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });

    if (widget.isList) {
      _pokemonViewModel.getPokemonsList(NetworkEndpoints.baseUrl);
    }
    else{
      _pokemonViewModel.getSavedPokemons();
    }
  }

  void _scrollListener() {
    if ((_scrollController.position.pixels + 500) >= _scrollController.position.maxScrollExtent && widget.isList) {
      _pokemonViewModel.getNextPokemonList();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    isMounted = false;
    LoadingOverlay.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context); // Inicializamos la clase Responsive
    String route = NavigationRoutes.initialRoute;

    if(!widget.isList){
      route = NavigationRoutes.listRoute;
    }

    return Scaffold(
      appBar: SearchCustomAppBar(
        title: "Hazte con todos!",
        onPressed: () {
          setState(() {
            searchPressed = true;
          });
        },
        searchPressed: searchPressed,
        callBackButton: () {
          setState(() {
            searchPressed = false;
          });
        },
        callBackSearch: (String query) {
          setState(() {
            this.query = query;
          });
        },
        backRoute: route,
      ),
      body: Stack(
        children: [
          BackgroundGradient(
            colorsList: Constants.colorsListScreen,
            child: PokemonVisualizer(
              scrollController: _scrollController,
              query: query,
              pokemons: pokemons,
              responsive: responsive, // Pasamos el responsive
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonVisualizer extends StatefulWidget {
  const PokemonVisualizer({
    super.key,
    required this.scrollController,
    required this.query,
    required this.pokemons,
    required this.responsive, // Pasamos el responsive
  });
  final ScrollController scrollController;
  final String query;
  final List<Pokemon> pokemons;
  final Responsive responsive; // Variable responsive

  @override
  State<PokemonVisualizer> createState() => _PokemonVisualizerState();
}

class _PokemonVisualizerState extends State<PokemonVisualizer> {
  List<Pokemon> totalPokemon = [];
  List<Pokemon> filteredPokemon = [];

  @override
  void initState() {
    super.initState();
    totalPokemon = widget.pokemons;
  }

  @override
  void didUpdateWidget(PokemonVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pokemons != widget.pokemons) {
      setState(() {
        totalPokemon = widget.pokemons;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    filteredPokemon = widget.query.isEmpty
        ? totalPokemon
        : totalPokemon.where((pokemon) =>
            pokemon.name.toLowerCase().startsWith(widget.query.toLowerCase())
        ).toList();

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: widget.responsive.widthPercent(5)), // Ajuste de padding
      controller: widget.scrollController,
      scrollDirection: Axis.vertical,
      itemCount: filteredPokemon.length,
      itemBuilder: (context, index) {
        final pokemon = filteredPokemon[index];
        return PokemonView(
          pokemon: pokemon,
          onDelete: () => {
            setState(() {
              totalPokemon.remove(pokemon);
            })
          }, // Pasamos el responsive al PokemonView
        );
      },
    );
  }
}
