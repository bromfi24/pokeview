
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

  static const Map<String, Color> typeColors = {
    'normal': Color(0xFFA8A77A),
    'fire': Color(0xFFEE8130),
    'water': Color(0xFF6390F0),
    'electric': Color(0xFFF7D02C),
    'grass': Color(0xFF7AC74C),
    'ice': Color(0xFF96D9D6),
    'fighting': Color(0xFFC22E28),
    'poison': Color(0xFFA33EA1),
    'ground': Color(0xFFE2BF65),
    'flying': Color(0xFFA98FF3),
    'psychic': Color(0xFFF95587),
    'bug': Color(0xFFA6B91A),
    'rock': Color(0xFFB6A136),
    'ghost': Color(0xFF735797),
    'dragon': Color(0xFF6F35FC),
    'dark': Color(0xFF705746),
    'steel': Color(0xFFB7B7CE),
    'fairy': Color(0xFFD685AD),
  };
  
}