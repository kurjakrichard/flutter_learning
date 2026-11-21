import '../repository/todo_table.dart';

class Todo {
  Todo({
    this.id,
    required this.title,
    this.description = '',
    required this.categoryId,
    this.todoDate,
    this.isFinished = false,
  });

  final int? id;
  final String title;
  final String description;

  /// id of the row in the categories table
  final int categoryId;
  final DateTime? todoDate;
  final bool isFinished;

  // Copy with a different finished state (the fields are final)
  Todo copyWith({bool? isFinished}) {
    return Todo(
      id: id,
      title: title,
      description: description,
      categoryId: categoryId,
      todoDate: todoDate,
      isFinished: isFinished ?? this.isFinished,
    );
  }

  // Convert a Todo object to a Map for the database.
  // The date is stored as ISO 8601 text, the bool as 0/1 (SQLite has no
  // DATE or BOOLEAN type).
  Map<String, dynamic> toMap() {
    return {
      if (id != null) TodoColumn.id.column: id,
      TodoColumn.title.column: title,
      TodoColumn.description.column: description,
      TodoColumn.categoryId.column: categoryId,
      TodoColumn.todoDate.column: todoDate?.toIso8601String(),
      TodoColumn.isFinished.column: isFinished ? 1 : 0,
    };
  }

  // Create a Todo object from a database row
  factory Todo.fromMap(Map<String, dynamic> map) {
    final date = map[TodoColumn.todoDate.column] as String?;
    return Todo(
      id: map[TodoColumn.id.column] as int?,
      title: map[TodoColumn.title.column] as String,
      description: map[TodoColumn.description.column] as String? ?? '',
      categoryId: map[TodoColumn.categoryId.column] as int,
      todoDate: date == null ? null : DateTime.parse(date),
      isFinished: map[TodoColumn.isFinished.column] == 1,
    );
  }
}
