import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;

class DBHelper {
  static const _dbName = 'minha_colecao.db';
  static const _dbVersion = 1;

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // On desktop (Windows, Linux, macOS) initialize the ffi implementation
    // so the global openDatabase API works (required when using
    // sqflite_common_ffi).
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqflite_ffi.sqfliteFfiInit();
      databaseFactory = sqflite_ffi.databaseFactoryFfi;
    }
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE collections (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        created_at TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        collection_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        image_path TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY(collection_id) REFERENCES collections(id) ON DELETE CASCADE
      );
    ''');
  }
}
