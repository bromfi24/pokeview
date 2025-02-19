

import 'package:pokeview/config/constants/constants.dart';
import 'package:pokeview/domain/datasources/pokemons_datasource.dart';
import 'package:pokeview/domain/entities/pokemon.dart';

import 'package:dio/dio.dart';
import 'package:pokeview/infrastructure/mappers/pokemon_mapper.dart';
import 'package:pokeview/infrastructure/model/list_pokemon_response.dart';
import 'package:pokeview/infrastructure/model/pokemon_response.dart';


class PokemondbDatasource extends PokemonsDatasource {

  //TODO: Controlar caso en el que se next o previous sean null

  static String next = '';
  static String previous = '';

  final dio = Dio(BaseOptions(
    baseUrl: Constants.API_URL_INITIAL_LIST,
  ));

  @override
  Future<List<Pokemon>> getPokemonsList(String url) async {
    //First we need to get the list of pokemons
    final response = await dio.get(url);
    final listResponse = ListPokemonResponse.fromJson(response.data);

    next = listResponse.next;
    previous = listResponse.previous ?? '';

    //Then we need to get the details of each pokemon
    List<Pokemon> pokemons = [];
    Pokemon pokemon;

    for (var result in listResponse.results) {
      pokemon = await getPokemon(result.url);
      pokemons.add(pokemon);
    }

    return Future.value(pokemons);
  }

  @override
  Future<List<Pokemon>> getNextPokemonList(){
    return getPokemonsList(next);
  }

  @override
  Future<List<Pokemon>> getPreviousPokemonList(){
    return getPokemonsList(previous);
  }

  Future<Pokemon> getPokemon(String url) async {
    //Get the details of the pokemon
    final response = await dio.get(url);
    final pokemonResponse = PokemonResponse.fromJson(response.data);
    Pokemon resul = PokemonMapper.pokemonDBToEntity(pokemonResponse);
    return Future.value(resul);
  }
}