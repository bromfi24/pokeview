
import 'package:pokeview/model/pokemon.dart';

abstract class PokemonsDatasource {
  Future<List<Pokemon>> getPokemonsList(String url);

  Future<List<Pokemon>>getNextPokemonList();

  Future<List<Pokemon>> getPreviousPokemonList();

  Future<Pokemon> getPokemonMoves(Pokemon pokemon) ;
}