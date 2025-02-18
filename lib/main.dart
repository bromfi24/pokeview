import 'package:flutter/material.dart';
import 'package:pokeview/config/constants/constants.dart';
import 'package:pokeview/config/router/app_router.dart';
import 'package:pokeview/config/theme/app_theme.dart';
import 'package:pokeview/infrastructure/datasources/pokemondb_datasource.dart';
import 'package:pokeview/infrastructure/repositories/pokemon_repository_imp.dart';
import 'package:pokeview/presentation/providers/pokemons_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonRepositroy = PokemonRepositoryImp(PokemondbDatasource());
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonsProvider(pokemonRepositroy)..getPokemonsList(Constants.API_URL_INITIAL_LIST)),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
      )
    );
  }
}
