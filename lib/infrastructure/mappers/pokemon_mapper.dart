

import 'package:pokeview/domain/entities/moves.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/infrastructure/model/pokemon_response.dart';

class PokemonMapper {
  static Pokemon pokemonDBToEntity(PokemonResponse pokemondb) {
    return Pokemon(
      id: pokemondb.id,
      name: pokemondb.name,
      imagesUrl: pokemondb.imagesUrl,
      height: pokemondb.height,
      weight: pokemondb.weight,
      baseXP: pokemondb.baseXP,
      types: pokemondb.types,
      moves: pokemondb.moves.map((move) => Moves(name: move.name, url: move.url, type: "")).toList(),
    );
  }
}
