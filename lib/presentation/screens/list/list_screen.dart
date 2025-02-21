import 'package:flutter/material.dart';
import 'package:pokeview/config/constants/constants.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/presentation/providers/pokemons_provider.dart';
import 'package:pokeview/presentation/screens/widgets/progress/poke_spin.dart';
import 'package:pokeview/presentation/screens/widgets/shared/background_gradient.dart';
import 'package:pokeview/presentation/screens/widgets/shared/search_app_bar.dart';
import 'package:pokeview/presentation/screens/widgets/views/pokemon_view.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  static const routeName = 'list-screen';

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  late ScrollController _scrollController;
  bool isMounted = false;
  bool searchPressed = false;
  String query = '';

  @override
  void initState() {
    super.initState();
    // Inicializando el controlador
    _scrollController = ScrollController();
    // Agregar un listener para detectar cuando el scroll ha llegado al final
    _scrollController.addListener(_scrollListener);
  }

  // El listener que se llama cuando el scroll cambia
  void _scrollListener() {
    // Comprobamos si hemos llegado al final de la lista
    if( (_scrollController.position.pixels + 500) >= _scrollController.position.maxScrollExtent ) {
      // Si es así, llamamos al método de carga de más Pokémon
      context.read<PokemonsProvider>().getNextPokemonsList();
      moveScrollToBottom();
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
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    final discoverProvider = context.watch<PokemonsProvider>();
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
              discoverProvider: discoverProvider,
              scrollController: _scrollController,
              query: query,
            ),
          ),
          // El indicador flotante de carga aparece solo si `isLoadingMore` es true
          Visibility(
            visible: discoverProvider.isLoadingMore,
            child: Align(
              alignment: Alignment.bottomRight,
              child: PokeSpin(infinite: true, width: 60, height: 60),
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
    required this.discoverProvider,
    required this.scrollController,
    required this.query,
  });

  final PokemonsProvider discoverProvider;
  final ScrollController scrollController;
  final String query;

  @override
  State<PokemonVisualizer> createState() => _PokemonVisualizerState();
}

class _PokemonVisualizerState extends State<PokemonVisualizer> {

  List<Pokemon> totalPokemon = [];
  List<Pokemon> filteredPokemon = [];


  @override
  void initState() {
    super.initState();
    //En un inicio las dos listas serán iguales
    totalPokemon = widget.discoverProvider.pokemons;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      totalPokemon = widget.discoverProvider.pokemons;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    //TODO: Revision de la lista de pokemons
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
