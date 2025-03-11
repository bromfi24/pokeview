import 'package:flutter/material.dart';
import 'package:pokeview/data/localdatabase/database_helper.dart';
import 'package:pokeview/data/localdatabase/pokemon_database.dart';
import 'package:pokeview/model/moves.dart';
import 'package:pokeview/model/pokemon.dart';
import 'package:pokeview/data/remote/http_client.dart';
import 'package:pokeview/model/pokemon_mapper.dart';
import 'package:pokeview/model/list_pokemon_response.dart';
import 'package:pokeview/model/pokemon_response.dart';
import 'package:pokeview/model/pokemon_response_moves.dart';
import 'dart:async';

import 'package:sqflite/sqflite.dart';



class PokemonRemoteImpl{

  final HttpClient _httpClient;
  PokemonRemoteImpl(this._httpClient);

  static String next = '';
  static String previous = '';

  List<Pokemon> pokemons = [];
  Database? _database;

   /// Inicializa la base de datos antes de usarla
  Future<void> _initDatabase() async {
    debugPrint('Inicializando base de datos o comprobando si ya está inicializada');
    _database = await DatabaseHelper.database;
  }

  Future<List<Pokemon>> getPokemonsList(String url) async {
    //First we need to get the list of pokemons
    final response = await _httpClient.dio.get(url);
    final listResponse = ListPokemonResponse.fromJson(response.data);

    next = listResponse.next;
    previous = listResponse.previous ?? '';

    //Then we need to get the details of each pokemon
    debugPrint('List of pokemons: ${listResponse.results}');

    List<Future<Pokemon>> futures = listResponse.results.map((result) => getPokemon(result.url)).toList();
    List<Pokemon> newPokemons = await Future.wait(futures);
    pokemons.addAll(newPokemons);

    return Future.value(pokemons);
  }

  Future<List<Pokemon>> getNextPokemonList(){
    return getPokemonsList(next);
  }

  Future<List<Pokemon>> getPreviousPokemonList(){
    return getPokemonsList(previous);
  }

  Future<Pokemon> getPokemon(String url) async {
    //Get the details of the pokemon
    final response = await _httpClient.dio.get(url);
    final pokemonResponse = PokemonResponse.fromJson(response.data);
    Pokemon resul = PokemonMapper.pokemonDBToEntity(pokemonResponse);
    debugPrint('Pokemon: ${resul.imagesUrl}');
    return Future.value(resul);
  }

  Future<Pokemon> getPokemonMoves(Pokemon pokemon) async {
    try {
      // Verificamos si el Pokémon ya tiene movimientos cargados
      if (pokemon.movimientosCargados) return pokemon;

      // Creamos una lista para almacenar los movimientos obtenidos
      List<Moves> movesResult = [];

      // Hacemos todas las solicitudes en paralelo con Future.wait
      await Future.wait(pokemon.moves.map((move) async {
        try {
          final response = await _httpClient.dio.get(move.url);
          final moveResponse = PokemonMovesResponse.fromJson(response.data);

            // Agregamos el movimiento a la lista temporal
            if (moveResponse.type != "") {
              movesResult.add(Moves(
                name: move.name,
                type: moveResponse.type,
                url: move.url,
              ));
            }

          //print('Move type: ${moveResponse.type}, Move name: ${move.name}');
        } catch (e) {
          //print('Error al obtener movimiento ${move.name}: $e');
        }
      }));

      // Añadimos los movimientos obtenidos a la lista del Pokémon
      pokemon.moves = movesResult;
      pokemon.movimientosCargados = true;

      return pokemon;
    } catch (e) {
      debugPrint('Error al obtener movimientos del Pokémon: $e');
      return pokemon;
    }
  }

  Future<void> savePokemon(Pokemon pokemon)async {
    await _initDatabase();
    await PokemonDatabase.insertPokemon(_database!, pokemon);
  }

  Future<void> deletePokemon(int id) async {
    await _initDatabase();
    await PokemonDatabase.deletePokemon(_database!,id);
  }

  Future<List<Pokemon>> getSavedPokemons() async {
    await _initDatabase();
    return await PokemonDatabase.getAllPokemons(_database!);
  }

  Future<bool> isPokemonFavorite(int id) async {
    await _initDatabase();
    return await PokemonDatabase.isPokemonFavorite(_database!,id);
  }
}
