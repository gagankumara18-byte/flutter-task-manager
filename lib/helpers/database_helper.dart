import 'dart:io';

import 'package:task_manager/models/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  final String tasksTable = 'task_table';
  final String colId = 'id';
  final String colTitle = 'title';
  final String colDate = 'date';
  final String colPriority = 'priority';
  final String colStatus = 'status';

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = '${dir.path}/todo_list.db';
    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $tasksTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$colTitle TEXT NOT NULL, $colDate TEXT NOT NULL, '
      '$colPriority TEXT NOT NULL, $colStatus INTEGER NOT NULL)',
    );
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    final Database database = await db;
    return database.query(tasksTable);
  }

  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList =
        taskMapList.map((Map<String, dynamic> map) => Task.fromMap(map)).toList();
    taskList.sort((Task a, Task b) => a.date.compareTo(b.date));
    return taskList;
  }

  Future<int> insertTask(Task task) async {
    final Database database = await db;
    return database.insert(tasksTable, task.toMap());
  }

  Future<int> updateTask(Task task) async {
    final Database database = await db;
    return database.update(
      tasksTable,
      task.toMap(),
      where: '$colId = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final Database database = await db;
    return database.delete(tasksTable, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTask() async {
    final Database database = await db;
    return database.delete(tasksTable);
  }
}
