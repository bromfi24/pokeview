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
import 'package:pokeview/presentation/view/pokemon/pokemon_view.dart';
import 'package:pokeview/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

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

  @override
  void initState() {
    super.initState();
    // Inicializando el controlador
    _scrollController = ScrollController();
    // Agregar un listener para detectar cuando el scroll ha llegado al final
    _scrollController.addListener(_scrollListener);

    _pokemonViewModel.pokemonListState.stream.listen((state){
      switch(state.status){
        case Status.LOADING:
          LoadingOverlay.show(context,  Alignment.center);
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

    _pokemonViewModel.getPokemonsList(NetworkEndpoints.baseUrl);
  }

  // El listener que se llama cuando el scroll cambia
  void _scrollListener() {
    // Comprobamos si hemos llegado al final de la lista
    if( (_scrollController.position.pixels + 500) >= _scrollController.position.maxScrollExtent ) {
      // Si es así, llamamos al método de carga de más Pokémon
      _pokemonViewModel.getNextPokemonList();
      //moveScrollToBottom();
    }
  }

    void moveScrollToBottom() {
    if( _scrollController.position.pixels + 100 <= _scrollController.position.maxScrollExtent ) return;
      _scrollController.animateTo(
        _scrollController.position.pixels + 120, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.fastOutSlowIn
      );
    }

  @override
  void dispose() {
    // Asegúrate de liberar el controlador cuando no lo necesites
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    isMounted = false;
    LoadingOverlay.hide();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchCustomAppBar(
        title: "Hazte con todos!",
        onPressed: (){
          setState(() {
            searchPressed = true;
          });
        }, 
        searchPressed: searchPressed,
        callBackButton: (){
          setState(() {
              searchPressed = false;
            }
          );
        },
        callBackSearch: (String query){
          setState(() {
            this.query = query;
          });
        }
      ),
      body: Stack(
        children: [
          BackgroundGradient(
            colorsList: Constants.colorsListScreen,
            child: PokemonVisualizer(
              scrollController: _scrollController,
              query: query,
              pokemons: pokemons,
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
  });
  final ScrollController scrollController;
  final String query;
  final List<Pokemon> pokemons;



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
        totalPokemon = widget.pokemons; // Actualiza cuando cambie la propiedad
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      controller: widget.scrollController, 
      scrollDirection: Axis.vertical,
      itemCount: filteredPokemon.length,
      itemBuilder: (context, index) {
        final pokemon = filteredPokemon[index];
        return PokemonView(pokemon: pokemon);
      },
    );
  }
}
