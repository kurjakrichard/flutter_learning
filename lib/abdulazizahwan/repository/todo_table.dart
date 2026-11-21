/// Name of the todos table.
const String todoTableName = 'todos';

/// Columns of the todos table, shared by [DatabaseConnection] (schema)
/// and [DatabaseHandler] (queries).
enum TodoColumn {
  id,
  title,
  description,
  categoryId,
  todoDate,
  isFinished;

  /// Column name in the database (same as the enum value's name).
  String get column => name;
}
