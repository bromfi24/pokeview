
import 'package:pokeview/domain/entities/pokemon.dart';

abstract class PokemonsRepository {
  Future<List<Pokemon>> getInitialListPokemons();
}