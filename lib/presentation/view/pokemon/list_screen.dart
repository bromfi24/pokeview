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
import 'package:pokeview/presentation/common/resources/responsive.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key, required this.isList});
  final bool isList;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _pokemonViewModel = inject<PokemonViewModel>();
  late ScrollController _scrollController;
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
      if (!mounted) return; // Comprobación de mounted antes de actuar
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context, Alignment.center);
          break;
        case Status.SUCCESS:
          LoadingOverlay.hide();
          if (mounted) { // Comprobación antes de setState
            setState(() {
              pokemons = state.data;
            });
          }
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          if (mounted) { // Comprobación antes de mostrar error
            ErrorOverlay.of(context).show(state.error);
          }
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });

    if (widget.isList) {
      _pokemonViewModel.getPokemonsList(NetworkEndpoints.baseUrl);
    } else {
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
    LoadingOverlay.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    String route = NavigationRoutes.initialRoute;

    if (!widget.isList) {
      route = NavigationRoutes.listRoute;
    }

    return Scaffold(
      appBar: SearchCustomAppBar(
        title: "Hazte con todos!",
        onPressed: () {
          if (mounted) { // Comprobación antes de setState
            setState(() {
              searchPressed = true;
            });
          }
        },
        searchPressed: searchPressed,
        callBackButton: () {
          if (mounted) { // Comprobación antes de setState
            setState(() {
              searchPressed = false;
            });
          }
        },
        callBackSearch: (String query) {
          if (mounted) { // Comprobación antes de setState
            setState(() {
              this.query = query;
            });
          }
        },
        backRoute: route,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundGradient(
              colorsList: Constants.colorsListScreen,
              child: PokemonVisualizer(
                scrollController: _scrollController,
                query: query,
                pokemons: pokemons,
                responsive: responsive,
              ),
            ),
          ],
        ),
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
    required this.responsive,
  });
  final ScrollController scrollController;
  final String query;
  final List<Pokemon> pokemons;
  final Responsive responsive;

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
      if (mounted) { // Comprobación antes de setState
        setState(() {
          totalPokemon = widget.pokemons;
        });
      }
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
      padding: EdgeInsets.symmetric(horizontal: widget.responsive.widthPercent(5)),
      controller: widget.scrollController,
      scrollDirection: Axis.vertical,
      itemCount: filteredPokemon.length,
      itemBuilder: (context, index) {
        final pokemon = filteredPokemon[index];
        return PokemonView(
          pokemon: pokemon,
          onDelete: () {
            if (mounted) { // Comprobación antes de setState
              setState(() {
                totalPokemon.remove(pokemon);
              });
            }
          },
        );
      },
    );
  }
}