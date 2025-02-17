

import 'package:pokeview/config/constants/constants.dart';
import 'package:pokeview/domain/datasources/pokemons_datasource.dart';
import 'package:pokeview/domain/entities/pokemon.dart';

import 'package:dio/dio.dart';


class PokemondbDatasource extends PokemonsDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: Constants.API_URL_LIST,
  ));

  @override
  Future<List<Pokemon>> getPokemons() {
    //Todo : Implementar llamada a la API
    return Future.value([]);
  }
}