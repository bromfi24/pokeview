
import 'package:pokeview/domain/entities/pokemon.dart';

abstract class PokemonsDatasource {
  Future<List<Pokemon>> getPokemonsList(String url);

  Future<List<Pokemon>>getNextPokemonList();

  Future<List<Pokemon>> getPreviousPokemonList();
}