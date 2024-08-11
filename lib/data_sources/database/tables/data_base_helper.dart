import "dart:io";

import 'package:flutter/foundation.dart';
import 'package:hotspot_chat/data_sources/database/tables/tables_creation.dart';
import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";

class DatabaseHelper {
  static const _databaseName = "hotspot_chat.db";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  late String documentsDirectory;

  Future<String> get path async {
    documentsDirectory = await getDatabasesPath();
    return join(documentsDirectory, _databaseName);
  }

  Future<Database?> get database async {
    if (kDebugMode) {
      path.then((value) => print('after path: $value'));
    }

    if (await File(await path).exists()) {
      _database = await openDatabase(await path);
      if (kDebugMode) {
        print('inside if ');
      }
      await _database!.execute('''PRAGMA foreign_keys = ON''');
      return _database;
    }
    if (kDebugMode) {
      print('before init');
    }
    // lazily instantiate the db the first time it is accessed
    await initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  initDatabase() async {
    if (kDebugMode) {
      print('initiate database');
    }
    // _database = await openDatabase(path);
    await openDatabase(await path, version: 1, onCreate: (db, vr) async {
      if (kDebugMode) {
        print('after create ');
      }
      await createTables(db);
    }, onOpen: (db) {
      _database = db;
      _database?.close();
    });
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database? db = await database;
    try {
      return await db!.insert(
        table,
        row,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e, s) {
      print("insert Error ${e.toString()}\n${s.toString()}");
      return Future.error(e);
    }
  }

  Future<List<Map<String, dynamic>>> getBetween(
      {required String tableName,
      required String col,
      required String start,
      required String end}) async {
    Database? db = await database;

    if (db != null) {
      return db.query(
        tableName,
        where: '? BETWEEN ? AND ?',
        whereArgs: [col, start, end],
      );
    }
    return [];
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(tableName, {orderBy}) async {
    Database? db = await database;
    var temp = await db!.query(tableName, orderBy: orderBy);
    print("queryAllRows");
    temp.forEach((row) {
      row.forEach((key, value) {
        print("$key : $value");
      });
    });
    if (temp.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 200));
      temp = await db.query(tableName, orderBy: orderBy);
    }
    return temp;
  }

  //query one row

  Future<Map<String, dynamic>?> getFirst(tableName, col, id) async {
    Database? db = await database;
    List<Map<String, Object?>> list =
        await db!.query(tableName, where: '$col= ?', whereArgs: [id]);
    if (list.isNotEmpty) {
      return list.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWhen(
      String tableName, String col, String id) async {
    Database? db = await database;
    return await db!.query(tableName, where: '$col= ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getWhenNot(
      String tableName, String col, String id) async {
    Database? db = await database;
    return await db!.query(tableName, where: '$col != ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getWhen2(
      tableName, String col1, String col2, String data1, String data2) async {
    Database? db = await database;
    return await db!.query(
      tableName,
      where: '$col1 = $data1 AND $col2 = $data2',
    );
  }

  Future<List<Map<String, dynamic>>> getWhenNot2(
      tableName, String col1, String data1, String data2) async {
    Database? db = await database;
    return await db!.query(
      tableName,
      where: '$col1 != ? AND $col1 != ?',
      whereArgs: [data1, data2],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table, int id) async {
    Database? db = await database;
    return await db!.delete(table, where: 'id= ?', whereArgs: [id]);
  }

  Future<int> deleteWhere<T>(String table, String col, T id) async {
    Database? db = await database;
    return await db!.delete(table, where: '$col = ?', whereArgs: [id]);
  }

  Future<int> deleteTableData(
    String table,
    int uid, {
    String col = 'user_id',
  }) async {
    Database? db = await database;
    return await db!.rawDelete("DELETE FROM $table Where $col=$uid");
  }
}
