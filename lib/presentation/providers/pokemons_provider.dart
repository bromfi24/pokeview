

import 'package:flutter/material.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/domain/repositories/pokemons_repository.dart';

class PokemonsProvider extends ChangeNotifier{
  bool initialLoading = true;
  final List<Pokemon> pokemons = [];
  final PokemonsRepository _pokemonsRepository;

  PokemonsProvider(this._pokemonsRepository);

  Future<void> getInitialListPokemons() async {
    pokemons.clear();
    pokemons.addAll(await _pokemonsRepository.getInitialListPokemons());
    initialLoading = false;
    notifyListeners();
  }

}