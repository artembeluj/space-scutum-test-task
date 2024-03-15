import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:test_task/shared/models/house_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static DatabaseFactory? _databaseFactory;

  DatabaseHelper._privateConstructor();

  Future<void> deleteHouse(int id) async {
    Database db = await instance.database;
    await db.delete('houses', where: 'id = ?', whereArgs: [id]);
  }

  Future<Database> get database async {
    _databaseFactory ??= databaseFactoryFfi;

    String path = join(await getDatabasesPath(), 'houses.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE houses(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      floors INTEGER
    )
  ''');
  }

  Future<int> insertHouse(House house) async {
    Database db = await instance.database;
    return await db.insert('houses', house.toMap());
  }

  Future<List<House>> getHouses() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('houses');
    return List.generate(maps.length, (i) {
      return House(
        id: maps[i]['id'],
        name: maps[i]['name'],
        floors: maps[i]['floors'],
      );
    });
  }
}
