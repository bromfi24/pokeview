
import 'package:pokeview/domain/entities/pokemon.dart';

abstract class PokemonsDatasource {
  Future<List<Pokemon>> getInitialListPokemons();
}