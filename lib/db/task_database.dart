import 'dart:async';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/task.dart';

class TaskDatabase{

  static final TaskDatabase instance = TaskDatabase._init();

  static Database? _database;

  TaskDatabase._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('task.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int verison) async{

    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableTask(
    ${TaskFields.id} $idType,
    ${TaskFields.finished} $boolType,
    ${TaskFields.title} $textType,
    ${TaskFields.date} $textType,

    )
    ''');
  }

  Future<Task> create(Task task) async {
    final db = await instance.database;

    final id = await db.insert(tableTask, task.toJson());
    return task.copy(id : id);
  }

  Future<Task> readTask(int id) async{
    final db = await instance.database;
    final maps = await db.query(
      tableTask,
      columns: TaskFields.values,
      where:  '${TaskFields.id} = ?',
      whereArgs: [id]
    );
    if(maps.isNotEmpty){
      return Task.fromJson(maps.first);
    }else{
      throw Exception ('ID $id not found');
    }
  }

  Future<List<Task>> readAllTask() async{
    final db = await instance.database;

    final orderBy = '${TaskFields.date} ASC';
    final result = await db.query(tableTask, orderBy: orderBy);
    return result.map((json) => Task.fromJson(json)).toList();
  }

  Future<List<Task>> readAllDoTask() async{
    final db = await instance.database;

    final orderBy = '${TaskFields.date} ASC';
    final result = await db.query(tableTask,where: '${TaskFields.finished} = false', orderBy: orderBy);
    return result.map((json) => Task.fromJson(json)).toList();
  }

  Future<List<Task>> readAllDoneTask() async{
    final db = await instance.database;

    final orderBy = '${TaskFields.date} DESC';
    final result = await db.query(tableTask,where: '${TaskFields.finished} = true', orderBy: orderBy);
    return result.map((json) => Task.fromJson(json)).toList();
  }

  Future<int> update(Task task) async{
    final db = await instance.database;
    return db.update(
      tableTask,
      task.toJson(),
      where: '${TaskFields.id} = ?',
      whereArgs: [task.id]);
  }


  Future<int> delete(int id) async{
    final db = await instance.database;
    return await db.delete(
      tableTask,
      where: '${TaskFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }

}

