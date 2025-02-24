// This file contains the Pokemon entity which is used to represent a Pokemon in the application.
import 'package:pokeview/domain/entities/moves.dart';

class Pokemon {
  final int id;
  final String name;
  final List<String> imagesUrl;
  final double height;
  final double weight;
  final double baseXP;
  final List<String> types;
  List<Moves> moves;
  bool movimientosCargados = false;

  Pokemon({
    required this.id,
    required this.name,
    required this.imagesUrl,
    required this.height,
    required this.weight,
    required this.types,
    required this.baseXP,
    required this.moves,
  });
}
