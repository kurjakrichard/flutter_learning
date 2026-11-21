import '../repository/category_table.dart';

class Category {
  Category({
    this.id,
    required this.name,
    this.description = '',
  });

  final int? id;
  final String name;
  final String description;

  // Copy with changed values (the fields are final)
  Category copyWith({String? name, String? description}) {
    return Category(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  // Convert a Category object to a Map for the database
  Map<String, dynamic> toMap() {
    return {
      if (id != null) CategoryColumn.id.column: id,
      CategoryColumn.name.column: name,
      CategoryColumn.description.column: description,
    };
  }

  // Create a Category object from a database row
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map[CategoryColumn.id.column] as int?,
      name: map[CategoryColumn.name.column] as String? ?? '',
      description: map[CategoryColumn.description.column] as String? ?? '',
    );
  }
}
