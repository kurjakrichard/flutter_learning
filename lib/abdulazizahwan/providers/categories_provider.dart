import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';
import '../repository/database_handler.dart';
import 'database_provider.dart';

/// Every category, ordered by name. Every screen watching it is rebuilt
/// after a save, delete or restore, so nobody has to reload by hand.
final categoriesProvider =
    AsyncNotifierProvider<CategoriesNotifier, List<Category>>(
        CategoriesNotifier.new);

/// Category id -> name, for showing a todo's category. Empty while loading.
final categoryNamesProvider = Provider<Map<int, String>>((ref) {
  final categories = ref.watch(categoriesProvider).value ?? const [];
  return {for (final category in categories) category.id!: category.name};
});

class CategoriesNotifier extends AsyncNotifier<List<Category>> {
  DatabaseHandler get _db => ref.read(databaseHandlerProvider);

  @override
  Future<List<Category>> build() => _db.getCategoryList();

  /// New category (no id): insert, existing one: update.
  /// Returns true if the database changed.
  Future<bool> save(Category category) => _write(
        () => category.id == null ? _db.insert(category) : _db.update(category),
      );

  Future<bool> delete(Category category) =>
      _write(() => _db.delete(category.id!));

  /// Undo delete: puts the category back with its original id.
  /// It's an insert, not an update: the row no longer exists, so an
  /// UPDATE ... WHERE id = ? would match 0 rows. toMap() contains the id.
  Future<bool> restore(Category category) {
    assert(category.id != null,
        'Only a previously saved category can be restored');
    return _write(() => _db.insert(category));
  }

  // Runs a database write, then reloads the list.
  // The write returns a row id / row count, so > 0 means success.
  Future<bool> _write(Future<int> Function() write) async {
    int result = 0;
    try {
      result = await write();
    } catch (e) {
      debugPrint('Category write failed: $e');
    }
    state = await AsyncValue.guard(_db.getCategoryList);
    return result > 0;
  }
}
