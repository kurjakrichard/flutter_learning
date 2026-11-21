/// Name of the categories table.
const String categoryTableName = 'categories';

/// Columns of the categories table, shared by [DatabaseConnection] (schema)
/// and [DatabaseHandler] (queries).
enum CategoryColumn {
  id,
  name,
  description;

  /// Column name in the database (same as the enum value's name).
  // `this.` is needed: inside the enum, plain `name` would mean
  // CategoryColumn.name, not the built-in Enum.name getter.
  String get column => this.name;
}
