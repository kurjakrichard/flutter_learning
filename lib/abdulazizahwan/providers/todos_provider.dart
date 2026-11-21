import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import '../repository/database_handler.dart';
import 'database_provider.dart';

/// Every todo, ordered by date. Watching screens are rebuilt after a write.
final todosProvider =
    AsyncNotifierProvider<TodosNotifier, List<Todo>>(TodosNotifier.new);

/// Category filter of the todo list, null: show every todo
final todoFilterProvider =
    NotifierProvider<TodoFilterNotifier, int?>(TodoFilterNotifier.new);

class TodoFilterNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int? categoryId) => state = categoryId;
}

class TodosNotifier extends AsyncNotifier<List<Todo>> {
  DatabaseHandler get _db => ref.read(databaseHandlerProvider);

  @override
  Future<List<Todo>> build() => _db.getTodoList();

  /// New todo (no id): insert, existing one: update.
  /// Returns true if the database changed.
  Future<bool> save(Todo todo) => _write(
        () => todo.id == null ? _db.insertTodo(todo) : _db.updateTodo(todo),
      );

  Future<bool> delete(Todo todo) => _write(() => _db.deleteTodo(todo.id!));

  /// Undo delete: puts the todo back with its original id.
  /// It's an insert, not an update: the row no longer exists, so an
  /// UPDATE ... WHERE id = ? would match 0 rows. toMap() contains the id.
  Future<bool> restore(Todo todo) {
    assert(todo.id != null, 'Only a previously saved todo can be restored');
    return _write(() => _db.insertTodo(todo));
  }

  /// Checkbox: saves the new state, then replaces only this todo in the
  /// list instead of reloading everything (no flicker, order unchanged)
  Future<bool> setFinished(Todo todo, bool isFinished) async {
    int result = 0;
    try {
      result = await _db.updateTodo(todo.copyWith(isFinished: isFinished));
    } catch (e) {
      debugPrint('Todo update failed: $e');
    }
    final todos = state.value;
    if (result > 0 && todos != null) {
      state = AsyncData([
        for (final t in todos)
          t.id == todo.id ? t.copyWith(isFinished: isFinished) : t,
      ]);
    }
    return result > 0;
  }

  // Runs a database write, then reloads the list.
  // The write returns a row id / row count, so > 0 means success.
  Future<bool> _write(Future<int> Function() write) async {
    int result = 0;
    try {
      result = await write();
    } catch (e) {
      debugPrint('Todo write failed: $e');
    }
    state = await AsyncValue.guard(_db.getTodoList);
    return result > 0;
  }
}
