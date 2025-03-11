import 'package:pokeview/model/pokemon.dart';

abstract class PokemonsRepository {
  Future<List<Pokemon>> getPokemonsList(String url);

  Future<List<Pokemon>>getNextPokemonList();

  Future<List<Pokemon>> getPreviousPokemonList();

  Future<Pokemon> getPokemonMoves(Pokemon pokemon) ;

  Future<void> savePokemon(Pokemon pokemon); 

  Future<void> deletePokemon(Pokemon pokemon);

  Future<List<Pokemon>> getSavedPokemons();

  Future<bool> isPokemonFavorite(int id);
}