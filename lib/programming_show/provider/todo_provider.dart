import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_learning/programming_show/repository/database_handler.dart';
import '../model/todo.dart';

class TodoNotifier extends AsyncNotifier<List<Todo>> {
  @override
  Future<List<Todo>> build() async {
    final dataList = await DatabaseHandler().selectAll('todo');
    return dataList.map((item) => Todo.fromMap(item)).toList();
  }

  Future<void> insertTodo(Todo todo) async {
    await DatabaseHandler().insertTodo(todo);
    state = AsyncData([...?state.value, todo]);
  }
}

final todoProvider =
    AsyncNotifierProvider<TodoNotifier, List<Todo>>(TodoNotifier.new);
