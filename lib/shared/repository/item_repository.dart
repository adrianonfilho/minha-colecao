import '../../core/database/db_helper.dart';
import '../models/item.dart';
import '../../core/logs/logger.dart';

class ItemRepository {
  final dbHelper = DBHelper.instance;

  Future<int> insert(Item item) async {
    final db = await dbHelper.database;
    AppLogger.i('Insert item: ${item.title}');
    return await db.insert('items', item.toMap());
  }

  Future<List<Item>> getByCollection(int collectionId) async {
    final db = await dbHelper.database;
    final res = await db.query('items',
        where: 'collection_id = ?', whereArgs: [collectionId], orderBy: 'id DESC');
    return res.map((e) => Item.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    final db = await dbHelper.database;
    AppLogger.i('Delete item: $id');
    return await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Item item) async {
    final db = await dbHelper.database;
    AppLogger.i('Update item: ${item.id}');
    return await db.update('items', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }
}
