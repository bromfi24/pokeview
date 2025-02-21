

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
      debugPrint('Error fetching Pokémon list: $e');
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
      debugPrint('Error fetching next Pokémon list: $e');
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
      debugPrint('Error fetching previous Pokémon list: $e');
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<Pokemon> getPokemonMoves(Pokemon pokemon) async {
    try {
      return await _pokemonsRepository.getPokemonMoves(pokemon);
    } catch (e) {
      debugPrint('Error fetching Pokémon moves: $e');
      return pokemon; // Devolvemos el Pokémon original sin cambios
    }
  }

}