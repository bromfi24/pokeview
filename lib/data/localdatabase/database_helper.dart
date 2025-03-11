import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }

  static Future<void> _createTables(Database db) async {
    // Tabla de pokemons
    await db.execute('''
      CREATE TABLE pokemons (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        height REAL NOT NULL,
        weight REAL NOT NULL,
        base_xp REAL NOT NULL,
        movimientos_cargados INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Tabla de imágenes de Pokémon
    await db.execute('''
      CREATE TABLE pokemon_images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pokemon_id INTEGER NOT NULL,
        image_url TEXT NOT NULL,
        FOREIGN KEY (pokemon_id) REFERENCES pokemons (id) ON DELETE CASCADE
      )
    ''');

    // Tabla de tipos de Pokémon
    await db.execute('''
      CREATE TABLE pokemon_types (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pokemon_id INTEGER NOT NULL,
        type TEXT NOT NULL,
        FOREIGN KEY (pokemon_id) REFERENCES pokemons (id) ON DELETE CASCADE
      )
    ''');

    // Tabla de movimientos
    await db.execute('''
      CREATE TABLE moves (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        url TEXT NOT NULL
      )
    ''');

    // Tabla intermedia para relación Pokémon-Movimientos
    await db.execute('''
      CREATE TABLE pokemon_moves (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pokemon_id INTEGER NOT NULL,
        move_id INTEGER NOT NULL,
        FOREIGN KEY (pokemon_id) REFERENCES pokemons (id) ON DELETE CASCADE,
        FOREIGN KEY (move_id) REFERENCES moves (id) ON DELETE CASCADE
      )
    ''');
  }
}
