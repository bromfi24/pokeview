import 'package:pokeview/model/moves.dart';
import 'package:pokeview/model/pokemon.dart';
import 'package:sqflite/sqflite.dart';

class PokemonDatabase {
  static Future<void> insertPokemon(Database db, Pokemon pokemon) async {
    // Insertar Pokémon en la tabla `pokemons`
    await db.insert(
      'pokemons',
      {
        'id': pokemon.id,
        'name': pokemon.name,
        'height': pokemon.height,
        'weight': pokemon.weight,
        'base_xp': pokemon.baseXP,
        'movimientos_cargados': pokemon.movimientosCargados ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Insertar imágenes del Pokémon en `pokemon_images`
    for (String imageUrl in pokemon.imagesUrl) {
      await db.insert(
        'pokemon_images',
        {
          'pokemon_id': pokemon.id,
          'image_url': imageUrl,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // Insertar tipos del Pokémon en `pokemon_types`
    for (String type in pokemon.types) {
      await db.insert(
        'pokemon_types',
        {
          'pokemon_id': pokemon.id,
          'type': type,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // Insertar movimientos del Pokémon en `moves` y `pokemon_moves`
    for (Moves move in pokemon.moves) {
      // Insertar el movimiento en `moves` si no existe
      int? moveId = await _getMoveId(db, move.name);
      moveId ??= await db.insert(
          'moves',
          {
            'name': move.name,
            'type': move.type,
            'url': move.url,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

      // Insertar la relación en `pokemon_moves`
      await db.insert(
        'pokemon_moves',
        {
          'pokemon_id': pokemon.id,
          'move_id': moveId,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

   /// Obtiene la lista de todos los Pokémon almacenados en la base de datos
  static Future<List<Pokemon>> getAllPokemons(Database db) async {
    final List<Map<String, dynamic>> pokemonMaps = await db.query('pokemons');
    List<Pokemon> pokemons = [];

    for (var pokemonMap in pokemonMaps) {
      int pokemonId = pokemonMap['id'];

      // Obtener imágenes
      final List<Map<String, dynamic>> imageMaps = await db.query(
        'pokemon_images',
        where: 'pokemon_id = ?',
        whereArgs: [pokemonId],
      );
      List<String> images = imageMaps.map((e) => e['image_url'] as String).toList();

      // Obtener tipos
      final List<Map<String, dynamic>> typeMaps = await db.query(
        'pokemon_types',
        where: 'pokemon_id = ?',
        whereArgs: [pokemonId],
      );
      List<String> types = typeMaps.map((e) => e['type'] as String).toList();

      // Obtener movimientos
      final List<Map<String, dynamic>> moveMaps = await db.rawQuery('''
        SELECT moves.id, moves.name, moves.type, moves.url 
        FROM moves 
        JOIN pokemon_moves ON moves.id = pokemon_moves.move_id 
        WHERE pokemon_moves.pokemon_id = ?
      ''', [pokemonId]);

      List<Moves> moves = moveMaps.map((e) => Moves(
        name: e['name'] as String,
        type: e['type'] as String,
        url: e['url'] as String,
      )).toList();

      // Crear objeto Pokémon y agregarlo a la lista
      pokemons.add(Pokemon(
        id: pokemonMap['id'],
        name: pokemonMap['name'],
        height: pokemonMap['height'],
        weight: pokemonMap['weight'],
        baseXP: pokemonMap['base_xp'],
        imagesUrl: images,
        types: types,
        moves: moves,
      ));
    }
    return pokemons;
  }

    /// Borra un Pokémon y sus relaciones de la base de datos
  static Future<void> deletePokemon(Database db, int pokemonId) async {
    await db.transaction((txn) async {
      await txn.delete('pokemon_images', where: 'pokemon_id = ?', whereArgs: [pokemonId]);
      await txn.delete('pokemon_types', where: 'pokemon_id = ?', whereArgs: [pokemonId]);
      await txn.delete('pokemon_moves', where: 'pokemon_id = ?', whereArgs: [pokemonId]);
      await txn.delete('pokemons', where: 'id = ?', whereArgs: [pokemonId]);
    });
  }

  /// Busca el ID de un movimiento si ya existe en la base de datos
  static Future<int?> _getMoveId(Database db, String moveName) async {
    final List<Map<String, dynamic>> result = await db.query(
      'moves',
      columns: ['id'],
      where: 'name = ?',
      whereArgs: [moveName],
    );
    return result.isNotEmpty ? result.first['id'] as int : null;
  }

    static Future<bool> isPokemonFavorite(Database db, int pokemonId) async {
    final List<Map<String, dynamic>> result = await db.query(
      'pokemons',
      where: 'id = ?',
      whereArgs: [pokemonId],
    );

    return result.isNotEmpty;
  }


}
