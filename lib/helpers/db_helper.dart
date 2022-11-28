import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> _dataBase() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(
        dbPath,
        'places.db',
      ),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_places(id, TEXT PRIMARY KEY, title TEXT, image TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertData(String table, Map<String, Object> data) async {
    final db = await DBHelper._dataBase();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper._dataBase();
    return db.query(table);
  }

  static Future<int> removeData(String id) async {
    final db = await DBHelper._dataBase();
    return await db.delete(
      'user_places',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
