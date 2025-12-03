import '../../core/database/db_helper.dart';
import '../models/collection.dart';
import '../../core/logs/logger.dart';

class CollectionRepository {
  final dbHelper = DBHelper.instance;

  Future<int> insert(Collection c) async {
    final db = await dbHelper.database;
    AppLogger.i('Insert collection: ${c.name}');
    return await db.insert('collections', c.toMap());
  }

  Future<List<Collection>> getAll() async {
    final db = await dbHelper.database;
    final res = await db.query('collections', orderBy: 'id DESC');
    return res.map((e) => Collection.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    final db = await dbHelper.database;
    AppLogger.i('Delete collection: $id');
    return await db.delete('collections', where: 'id = ?', whereArgs: [id]);
  }
}
