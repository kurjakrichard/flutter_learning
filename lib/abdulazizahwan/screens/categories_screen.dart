import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import '../models/category.dart';
import '../providers/categories_provider.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Rebuilds by itself after every save / delete / restore
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.categories),
      ),
      body: categoriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(l10n.loadError)),
        data: (categories) => ListView.builder(
          itemCount: categories.length,
          itemBuilder: ((context, index) {
            final category = categories[index];
            return Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(
                      onPressed: () {
                        _showFormDialog(context, l10n.editCategory, category);
                      },
                      icon: const Icon(Icons.edit)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(category.name),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () => _deleteCategory(category))
                    ],
                  ),
                  subtitle: Text(category.description),
                ),
              ),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showFormDialog(context, l10n.newCategory, Category(name: ''));
        },
      ),
    );
  }

  // Confirm dialog: true = delete, false = keep
  Future<bool> _confirmDelete(Category category) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.deleteCategoryTitle),
        content: Text(l10n.deleteCategoryMessage(category.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  Future<void> _deleteCategory(Category category) async {
    if (!await _confirmDelete(category)) return;
    if (!mounted) return;

    final l10n = AppLocalizations.of(context);
    // Grab the messenger and the notifier before the async gap: the undo
    // button can be pressed after this screen is closed, when ref is gone
    final messenger = ScaffoldMessenger.of(context);
    final notifier = ref.read(categoriesProvider.notifier);

    final success = await notifier.delete(category);
    _showResultSnackBar(
      messenger,
      success: success,
      successMessage: l10n.categoryDeleted,
      errorMessage: l10n.categoryDeleteError,
      // Undo is only offered when something was actually deleted
      action: success
          ? SnackBarAction(
              label: l10n.undo,
              onPressed: () =>
                  _restoreCategory(category, notifier, messenger, l10n),
            )
          : null,
    );
  }

  // Undo delete: put the deleted category back with its original id
  // Everything is passed in, so the restore also works if the screen was
  // already closed (only the snackbar is skipped then)
  Future<void> _restoreCategory(Category category, CategoriesNotifier notifier,
      ScaffoldMessengerState messenger, AppLocalizations l10n) async {
    final success = await notifier.restore(category);
    _showResultSnackBar(
      messenger,
      success: success,
      successMessage: l10n.categoryRestored,
      errorMessage: l10n.categoryRestoreError,
    );
  }

  // Success: default snackbar, error: snackbar in the theme's error color
  void _showResultSnackBar(
    ScaffoldMessengerState messenger, {
    required bool success,
    required String successMessage,
    required String errorMessage,
    SnackBarAction? action,
  }) {
    // Called after an await: the screen may already be closed
    if (!mounted) return;
    final colorScheme = Theme.of(context).colorScheme;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            success ? successMessage : errorMessage,
            style: success ? null : TextStyle(color: colorScheme.onError),
          ),
          backgroundColor: success ? null : colorScheme.error,
          action: action,
          // A snackbar with an action would stay open by default
          persist: false,
          duration: const Duration(seconds: 5),
        ),
      );
  }

  Future<void> _showFormDialog(
      BuildContext context, String title, Category category) {
    _categoryController.text = category.name;
    _descriptionController.text = category.description;
    final l10n = AppLocalizations.of(context);
    String? nameError;

    return showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(builder: (dialogContext, setDialogState) {
            return AlertDialog(
              actions: [
                TextButton(
                  onPressed: () async {
                    final name = _categoryController.text.trim();
                    final description = _descriptionController.text.trim();

                    // Validate before saving
                    if (name.isEmpty) {
                      setDialogState(() => nameError = l10n.categoryRequired);
                      return;
                    }

                    // Grab the screen's messenger before the async gap
                    final messenger = ScaffoldMessenger.of(context);
                    final notifier = ref.read(categoriesProvider.notifier);

                    // New object with the typed values; the original stays unchanged
                    final toSave =
                        category.copyWith(name: name, description: description);
                    final success = await notifier.save(toSave);

                    if (!dialogContext.mounted) return;
                    Navigator.pop(dialogContext);
                    _showResultSnackBar(
                      messenger,
                      success: success,
                      successMessage: l10n.categorySaved,
                      errorMessage: l10n.categorySaveError,
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith(
                          (state) => Colors.blue)),
                  child: Text(l10n.save,
                      style: const TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith(
                          (state) => Colors.red)),
                  child: Text(
                    l10n.cancel,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
              title: Text(title),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _categoryController,
                      onChanged: (_) {
                        if (nameError != null) {
                          setDialogState(() => nameError = null);
                        }
                      },
                      decoration: InputDecoration(
                          hintText: l10n.categoryHint,
                          labelText: l10n.category,
                          errorText: nameError),
                    ),
                    TextField(
                      controller: _descriptionController,
                      // Same limit the old model setter enforced silently
                      maxLength: 255,
                      decoration: InputDecoration(
                          hintText: l10n.descriptionHint,
                          labelText: l10n.description),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
