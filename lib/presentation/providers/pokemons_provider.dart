

import 'package:flutter/material.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/domain/repositories/pokemons_repository.dart';

class PokemonsProvider extends ChangeNotifier{
  bool isLoadingMore = true;
  final List<Pokemon> pokemons = [];
  final PokemonsRepository _pokemonsRepository;

  PokemonsProvider(this._pokemonsRepository);

  Future<void> getPokemonsList(String url) async {
    isLoadingMore = true;
    notifyListeners();  

    pokemons.clear();
    try {
      pokemons.addAll(await _pokemonsRepository.getPokemonsList(url));
    } catch (e) {
      print('Error fetching Pokémon list: $e');
    } finally {
      isLoadingMore = false;
      notifyListeners();  
    }
  }

    Future<void> getNextPokemonsList() async {
    if (isLoadingMore) return; 
    isLoadingMore = true;
    notifyListeners();

    try {
      pokemons.addAll(await _pokemonsRepository.getNextPokemonList());
    } catch (e) {
      print('Error fetching next Pokémon list: $e');
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> getPreviousPokemonsList() async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    notifyListeners();

    try {
      pokemons.addAll(await _pokemonsRepository.getPreviousPokemonList());
    } catch (e) {
      print('Error fetching previous Pokémon list: $e');
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }
}