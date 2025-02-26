class MovesApi{
  final String name;
  final String url;

  MovesApi({required this.name, required this.url});
}

class PokemonResponse {
  final int id;
  final String name;
  final List<String> imagesUrl;
  final double height;
  final double weight;
  final double baseXP;
  final List<String> types;
  final List<MovesApi> moves;

  PokemonResponse({
    required this.id,
    required this.name,
    required this.imagesUrl,
    required this.height,
    required this.weight,
    required this.types,
    required this.baseXP,
    required this.moves,
  });

  factory PokemonResponse.fromJson(Map<String, dynamic> json) {
    return PokemonResponse(
      id: json['id'],
      name: json['name'],
      imagesUrl: [
        json['sprites']['front_default'] ?? '',
        json['sprites']['back_default'] ?? '',
        json['sprites']['front_shiny'] ?? '',
        json['sprites']['back_shiny'] ?? '',
      ],
      height: (json['height'] as int).toDouble() / 10, // Convert to meters
      weight: (json['weight'] as int).toDouble() / 10, // Convert to kg
      baseXP: (json['base_experience'] as num).toDouble(),
      types: (json['types'] as List)
          .map((typeInfo) => typeInfo['type']['name'] as String)
          .toList(),
      moves: (json['moves'] as List)
          .map((moveInfo) {
            // Aquí creamos un objeto MovesApi con nombre y URL
            final move = moveInfo['move'];
            return MovesApi(
              name: move['name'],
              url: move['url'],
            );
          })
          .toList(),
    );
  }
}


