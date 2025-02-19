import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeview/config/constants/constants.dart';
import 'package:pokeview/presentation/providers/pokemons_provider.dart';
import 'package:pokeview/presentation/screens/widgets/shared/background_gradient.dart';
import 'package:pokeview/presentation/screens/widgets/views/pokemon_view.dart';
import 'package:pokeview/presentation/screens/widgets/shared/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  static const routeName = 'list-screen';

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  late ScrollController _scrollController;
  bool isMounted = false;

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
      appBar: CustomAppBar(title: "Hazte con todos!"),
      body: BackgroundGradient(
        colorsList: Constants.colorsListScreen, 
        child: PokemonVisualizer(
          discoverProvider: discoverProvider, 
          scrollController: _scrollController )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> context.pop(),
        // child: const Icon(Icons.arrow_back_ios_new_outlined),
        child: discoverProvider.isLoadingMore 
          ? SpinPerfect(
              infinite: true,
              child: const Icon(Icons.refresh_rounded)
            )
          : FadeIn(child: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
    );
  }
}

class PokemonVisualizer extends StatefulWidget {
  const PokemonVisualizer({
    super.key,
    required this.discoverProvider,
    required this.scrollController,
  });

  final PokemonsProvider discoverProvider;
  final ScrollController scrollController;

  @override
  State<PokemonVisualizer> createState() => _PokemonVisualizerState();
}

class _PokemonVisualizerState extends State<PokemonVisualizer> {
  @override
  Widget build(BuildContext context) { 
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      controller: widget.scrollController, 
      scrollDirection: Axis.vertical,
      itemCount: widget.discoverProvider.pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = widget.discoverProvider.pokemons[index];
        return PokemonView(pokemon: pokemon);
      },
    );
  }
}
