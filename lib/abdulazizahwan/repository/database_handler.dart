import 'dart:async';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../models/category.dart';
import '../models/todo.dart';
import 'category_table.dart';
import 'database_connection.dart';
import 'todo_table.dart';

class DatabaseHandler {
  final DatabaseConnection _databaseConnection = DatabaseConnection();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _databaseConnection.initializeDB();
  }

  // Fetch Operation: Get all categories, ordered by the given column
  Future<List<Category>> getCategoryList(
      {CategoryColumn orderBy = CategoryColumn.name}) async {
    final db = await database;
    final rows = await db.query(categoryTableName, orderBy: orderBy.column);
    return rows.map(Category.fromMap).toList();
  }

  // Insert Operation: Insert new record to database
  Future<int> insert(Category category) async {
    final db = await database;
    return db.insert(categoryTableName, category.toMap());
  }

  // Update Operation: Update record in the database
  Future<int> update(Category category) async {
    final db = await database;
    return db.update(categoryTableName, category.toMap(),
        where: '${CategoryColumn.id.column} = ?', whereArgs: [category.id]);
  }

  // Delete Operation: Delete record from database
  Future<int> delete(int id) async {
    final db = await database;
    return db.delete(categoryTableName,
        where: '${CategoryColumn.id.column} = ?', whereArgs: [id]);
  }

  // Fetch Operation: Get all todos, by date (todos without a date last),
  // then in the order they were added
  Future<List<Todo>> getTodoList() async {
    final db = await database;
    final date = TodoColumn.todoDate.column;
    final rows = await db.query(todoTableName,
        orderBy: '$date IS NULL, $date, ${TodoColumn.id.column}');
    return rows.map(Todo.fromMap).toList();
  }

  // Insert Operation: Insert new todo, returns the new row id
  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    return db.insert(todoTableName, todo.toMap());
  }

  // Update Operation: Update todo, returns the number of changed rows
  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    return db.update(todoTableName, todo.toMap(),
        where: '${TodoColumn.id.column} = ?', whereArgs: [todo.id]);
  }

  // Delete Operation: Delete todo, returns the number of deleted rows
  Future<int> deleteTodo(int id) async {
    final db = await database;
    return db.delete(todoTableName,
        where: '${TodoColumn.id.column} = ?', whereArgs: [id]);
  }
}
