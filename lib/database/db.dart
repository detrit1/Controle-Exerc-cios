import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'exercicios.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE exercicios(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            grupoMuscular TEXT,
            tipoEquipamento TEXT,
            series INTEGER,
            repeticoes INTEGER,
            carga REAL,
            observacoes TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await _getDatabase();
    return db.insert(table, data);
  }

  static Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await _getDatabase();
    return db.query(table);
  }

  static Future<int> update(String table, int id, Map<String, dynamic> data) async {
    final db = await _getDatabase();
    return await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  static Future<int> delete(String table, int id) async {
    final db = await _getDatabase();
    return db.delete(table, where: "id = ?", whereArgs: [id]);
  }
}
