import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() => sql.getDatabasesPath().then(
        (dbPath) => sql.openDatabase(
          path.join(
            dbPath,
            'places.db',
          ),
          onCreate: (db, version) => db.execute(
              'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_long REAL, address TEXT)'),
          version: 1,
        ),
      );

  static Future<void> insert(String table, Map<String, Object> data) =>
      DBHelper.database().then(
        (sqlDB) => sqlDB.insert(
          table,
          data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace,
        ),
      );

  static Future<List<Map<String, dynamic>>> getData(String table) =>
      DBHelper.database().then(
        (sqlDB) => sqlDB.query(table),
      );
}
