

import 'package:pokeview/domain/datasources/pokemons_datasource.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/domain/repositories/pokemons_repository.dart';

class PokemonRepositoryImp extends PokemonsRepository{

  final PokemonsDatasource _pokemonDatasource;
  PokemonRepositoryImp(this._pokemonDatasource);

  @override
  Future<List<Pokemon>> getInitialListPokemons() {
    return _pokemonDatasource.getInitialListPokemons();
  }

}