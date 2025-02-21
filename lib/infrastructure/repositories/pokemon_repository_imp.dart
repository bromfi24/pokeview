

import 'package:pokeview/domain/datasources/pokemons_datasource.dart';
import 'package:pokeview/domain/entities/pokemon.dart';
import 'package:pokeview/domain/repositories/pokemons_repository.dart';

class PokemonRepositoryImp extends PokemonsRepository{

  final PokemonsDatasource _pokemonDatasource;
  PokemonRepositoryImp(this._pokemonDatasource);

  @override
  Future<List<Pokemon>> getPokemonsList(String url) {
    return _pokemonDatasource.getPokemonsList(url);
  }

  @override
  Future<List<Pokemon>> getNextPokemonList(){
    return _pokemonDatasource.getNextPokemonList();
  }

  @override
  Future<List<Pokemon>> getPreviousPokemonList(){
    return _pokemonDatasource.getPreviousPokemonList();
  }


  @override
  Future<Pokemon> getPokemonMoves(Pokemon pokemon)  {
    return _pokemonDatasource.getPokemonMoves(pokemon);
  }
}