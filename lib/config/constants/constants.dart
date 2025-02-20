
// ignore_for_file: constant_identifier_names due to fit into the good practices of the project
import 'package:flutter/material.dart';

enum PokemonTypes {
    normal,
    fighting,
    flying,
    poison,
    ground,
    rock,
    bug,
    ghost,
    steel,
    fire,
    water,
    grass,
    electric,
    psychic,
    ice,
    dragon,
    dark,
    fairy,
    unknown,
    shadow,
}

class Constants {
  static const String API_URL_INITIAL_LIST = 'https://pokeapi.co/api/v2/pokemon/';
  static const String ROUTE_ASSETS_TYPE = 'assets/images/pokemon_types/';
  static List<Color> colorsMainScreen = [
    Colors.red,
    Colors.white
  ];
  static List<Color> colorsListScreen = [
    Colors.blue,
    Colors.white
  ];
  static List<Color> colorsDetailScreen = [
    Colors.blue,
    Colors.white
  ];
  
}