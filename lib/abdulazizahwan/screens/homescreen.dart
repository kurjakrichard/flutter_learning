import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import 'package:flutter_learning/settings/settings_tile.dart';
import 'categories_screen.dart';
import 'todo_screen.dart';
import '../models/todo.dart';
import '../providers/categories_provider.dart';
import '../providers/todos_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

// Menu value of "All categories" (real category ids start at 1).
// A null menu value can't be used: selecting it counts as cancel.
const int _allCategories = -1;

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // New todo: no argument, edit: the todo to edit.
  // No reload afterwards: todosProvider updates this screen by itself.
  void _openTodoScreen([Todo? todo]) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TodoScreen(todo: todo)),
    );
  }

  // The filter is ignored if its category has been deleted since
  int? _activeFilter(Map<int, String> categoryNames) {
    final filterId = ref.watch(todoFilterProvider);
    return categoryNames.containsKey(filterId) ? filterId : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todolist Sqflite'),
        actions: [_buildFilterButton()],
      ),
      drawer: drawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTodoScreen(),
        child: const Icon(Icons.add),
      ),
      body: _buildTodoList(),
    );
  }

  // Filter menu: "All categories" + one item per category, the active one
  // checked. The icon is filled while a filter is on.
  Widget _buildFilterButton() {
    final l10n = AppLocalizations.of(context);
    final categoryNames = ref.watch(categoryNamesProvider);
    final filterId = _activeFilter(categoryNames);
    final filtering = filterId != null;

    return PopupMenuButton<int>(
      icon: Icon(filtering ? Icons.filter_alt : Icons.filter_alt_outlined),
      tooltip: l10n.filterByCategory,
      initialValue: filterId ?? _allCategories,
      onSelected: (value) => ref
          .read(todoFilterProvider.notifier)
          .set(value == _allCategories ? null : value),
      itemBuilder: (context) => [
        CheckedPopupMenuItem<int>(
          value: _allCategories,
          checked: !filtering,
          child: Text(l10n.allCategories),
        ),
        if (categoryNames.isNotEmpty) const PopupMenuDivider(),
        for (final entry in categoryNames.entries)
          CheckedPopupMenuItem<int>(
            value: entry.key,
            checked: entry.key == filterId,
            child: Text(entry.value),
          ),
      ],
    );
  }

  Widget _buildTodoList() {
    final l10n = AppLocalizations.of(context);
    final todosAsync = ref.watch(todosProvider);
    // Category names follow renames / deletes on the categories screen
    final categoryNames = ref.watch(categoryNamesProvider);

    final List<Todo> allTodos;
    switch (todosAsync) {
      case AsyncData(:final value):
        allTodos = value;
      case AsyncError():
        return Center(child: Text(l10n.loadError));
      default:
        return const Center(child: CircularProgressIndicator());
    }
    if (allTodos.isEmpty) {
      return Center(child: Text(l10n.todoListEmpty));
    }

    // Filtering happens here, on the loaded list: no extra DB query
    final filterId = _activeFilter(categoryNames);
    final todos = filterId == null
        ? allTodos
        : allTodos.where((todo) => todo.categoryId == filterId).toList();
    if (todos.isEmpty) {
      return Center(child: Text(l10n.noTodosInCategory));
    }

    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat.yMMMd(locale);

    return ListView.builder(
      // Bottom padding so the FAB doesn't cover the last item
      padding: const EdgeInsets.only(top: 4, bottom: 88),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        final date = todo.todoDate;
        // Category name and date in one line, e.g. "Munka · 2026. nov. 21."
        final details = [
          categoryNames[todo.categoryId] ?? '',
          if (date != null) dateFormat.format(date),
        ].where((part) => part.isNotEmpty).join(' · ');

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Checkbox(
              value: todo.isFinished,
              onChanged: (value) => _toggleFinished(todo, value ?? false),
            ),
            // Tapping anywhere on the row toggles it as well
            onTap: () => _toggleFinished(todo, !todo.isFinished),
            title: Text(
              todo.title,
              style: todo.isFinished
                  ? TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Theme.of(context).disabledColor,
                    )
                  : null,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: l10n.editTodo,
                  onPressed: () => _openTodoScreen(todo),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  tooltip: l10n.delete,
                  onPressed: () => _deleteTodo(todo),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (todo.description.isNotEmpty) Text(todo.description),
                if (details.isNotEmpty)
                  Text(
                    details,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Checkbox: the notifier saves it and updates only this item in the list
  Future<void> _toggleFinished(Todo todo, bool isFinished) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final success =
        await ref.read(todosProvider.notifier).setFinished(todo, isFinished);
    if (!success) {
      _showResultSnackBar(
        messenger,
        success: false,
        successMessage: '',
        errorMessage: l10n.todoUpdateError,
      );
    }
  }

  // Confirm dialog: true = delete, false = keep
  Future<bool> _confirmDelete(Todo todo) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.deleteTodoTitle),
        content: Text(l10n.deleteTodoMessage(todo.title)),
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

  Future<void> _deleteTodo(Todo todo) async {
    if (!await _confirmDelete(todo)) return;
    if (!mounted) return;

    final l10n = AppLocalizations.of(context);
    // Grab the messenger and the notifier before the async gap: the undo
    // button can be pressed after this screen is closed, when ref is gone
    final messenger = ScaffoldMessenger.of(context);
    final notifier = ref.read(todosProvider.notifier);

    final success = await notifier.delete(todo);
    _showResultSnackBar(
      messenger,
      success: success,
      successMessage: l10n.todoDeleted,
      errorMessage: l10n.todoDeleteError,
      // Undo is only offered when something was actually deleted
      action: success
          ? SnackBarAction(
              label: l10n.undo,
              onPressed: () => _restoreTodo(todo, notifier, messenger, l10n),
            )
          : null,
    );
  }

  // Undo delete: put the deleted todo back with its original id.
  // Everything is passed in, so it also works if this screen was closed
  // in the meantime (only the snackbar is skipped then)
  Future<void> _restoreTodo(Todo todo, TodosNotifier notifier,
      ScaffoldMessengerState messenger, AppLocalizations l10n) async {
    final success = await notifier.restore(todo);
    _showResultSnackBar(
      messenger,
      success: success,
      successMessage: l10n.todoRestored,
      errorMessage: l10n.todoRestoreError,
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

  Widget drawerWidget() {
    final l10n = AppLocalizations.of(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text('Kurják Richárd'),
            accountEmail: const Text('kurjak.richard@gmail.com'),
            currentAccountPicture: CircleAvatar(
                backgroundImage: Image.asset('assets/cv.jpg').image),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(l10n.mainMenu),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: Text(l10n.todos),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const HomeScreen();
              }));
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: Text(l10n.categories),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const CategoriesScreen();
              }));
            },
          ),
          const SettingsTile(),
        ],
      ),
    );
  }
}
