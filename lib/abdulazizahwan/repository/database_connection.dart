import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'dart:io';
import 'category_table.dart';
import 'todo_table.dart';

class DatabaseConnection {
  static DatabaseConnection? _databaseConnection;
  DatabaseConnection._createInstance();

  // 1: categories
  // 2: todos table added
  static const int _dbVersion = 2;

  factory DatabaseConnection() {
    _databaseConnection ??= DatabaseConnection._createInstance();
    return _databaseConnection!;
  }

  Future<Database> initializeDB() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'todolist.db');

    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      DatabaseFactory databaseFactory = databaseFactoryFfi;
      Database database = await databaseFactory.openDatabase(path,
          options: OpenDatabaseOptions(
            onCreate: _createDb,
            onUpgrade: _upgradeDb,
            version: _dbVersion,
          ));
      return database;
    } else {
      return openDatabase(
        path,
        onCreate: _createDb,
        onUpgrade: _upgradeDb,
        version: _dbVersion,
      );
    }
  }

  // New database: create every table of the latest version
  Future<void> _createDb(Database database, int newVersion) async {
    await _createCategoriesTable(database);
    await _createTodosTable(database);
  }

  // Existing database from an older version: only add what's missing,
  // so the stored categories are kept
  Future<void> _upgradeDb(
      Database database, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _createTodosTable(database);
    }
  }

  Future<void> _createCategoriesTable(Database database) async {
    await database.execute(
      'CREATE TABLE $categoryTableName ('
      '${CategoryColumn.id.column} INTEGER PRIMARY KEY AUTOINCREMENT, '
      '${CategoryColumn.name.column} TEXT, '
      '${CategoryColumn.description.column} TEXT)',
    );
  }

  Future<void> _createTodosTable(Database database) async {
    await database.execute(
      'CREATE TABLE $todoTableName ('
      '${TodoColumn.id.column} INTEGER PRIMARY KEY AUTOINCREMENT, '
      '${TodoColumn.title.column} TEXT NOT NULL, '
      '${TodoColumn.description.column} TEXT, '
      '${TodoColumn.categoryId.column} INTEGER NOT NULL, '
      '${TodoColumn.todoDate.column} TEXT, '
      '${TodoColumn.isFinished.column} INTEGER NOT NULL DEFAULT 0)',
    );
  }
}
