import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'my_table';
  static const productId = 'productId';
  static const productName = 'productName';
  static const productImage = 'productImage';
  static const price = 'price';
  static const quantity = 'quantity';

  /// make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  /// this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  /// SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $productName TEXT NOT NULL,
            $productImage INTEGER NOT NULL,
            $price INTEGER NOT NULL,
            $quantity INTEGER NOT NULL,
            $productId INTEGER NOT NULL
          )
          ''');
  }

  /// inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  /// All of the rows are returned as a list of maps, where each map is
  /// a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }


  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[productId];
    return await db!
        .update(table, row, where: '$productId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$productId = ?', whereArgs: [id]);
  }
}
