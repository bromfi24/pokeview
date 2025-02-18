
import 'package:pokeview/domain/entities/pokemon.dart';

abstract class PokemonsRepository {
  Future<List<Pokemon>> getPokemonsList(String url);

  Future<List<Pokemon>>getNextPokemonList();

  Future<List<Pokemon>> getPreviousPokemonList();
}