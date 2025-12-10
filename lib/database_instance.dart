import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'product_model.dart';

class DatabaseInstance {
  final String _dbName = "my_database.db";
  final int _dbVersion = 1;

  final String table = "product";

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        category TEXT,
        created_at TEXT,
        updated_at TEXT
      )
    """);
  }

  // Insert
  Future<int> insertProduct(ProductModel product) async {
    Database db = await database;
    return await db.insert(table, product.toMap());
  }
}
