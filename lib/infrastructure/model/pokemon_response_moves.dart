class PokemonMovesResponse {
  final String type;

  PokemonMovesResponse({required this.type});

  factory PokemonMovesResponse.fromJson(Map<String, dynamic> json) {
    return PokemonMovesResponse(
      type: json['type']['name'] as String,  // Acceso correcto si 'type' es un objeto con 'name'
    );
  }
}
