import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import '../extensions/date_time_extensions.dart';
import '../models/todo.dart';
import '../providers/categories_provider.dart';
import '../providers/todos_provider.dart';

/// New todo: `TodoScreen()`, edit: `TodoScreen(todo: existing)`.
class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({Key? key, this.todo}) : super(key: key);

  /// The todo being edited, null for a new todo
  final Todo? todo;

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
  int? _selectedCategoryId;
  bool _saving = false;

  bool get _isEditing => widget.todo != null;

  // Values the form started with, to detect unsaved changes
  late final String _initialTitle;
  late final String _initialDescription;
  late final DateTime? _initialDate;
  late final int? _initialCategoryId;

  // Edit: the todo's category may have been deleted since. The dropdown only
  // accepts a value that is in its items, so a missing id counts as none.
  // (While the categories are still loading the id is kept as it is.)
  int? _existingCategoryId(int? id) {
    final categories = ref.read(categoriesProvider).value;
    if (categories == null) return id;
    return categories.any((c) => c.id == id) ? id : null;
  }

  bool get _hasChanges =>
      _titleController.text.trim() != _initialTitle ||
      _descriptionController.text.trim() != _initialDescription ||
      _selectedDate != _initialDate ||
      // A deleted category isn't the user's change: compare existing ids
      _existingCategoryId(_selectedCategoryId) !=
          _existingCategoryId(_initialCategoryId);

  @override
  void initState() {
    super.initState();
    // Edit: fill the form with the existing values
    final todo = widget.todo;
    if (todo != null) {
      _titleController.text = todo.title;
      _descriptionController.text = todo.description;
      _selectedDate = todo.todoDate;
      _selectedCategoryId = todo.categoryId;
    }
    _initialTitle = _titleController.text;
    _initialDescription = _descriptionController.text;
    _initialDate = _selectedDate;
    _initialCategoryId = _selectedCategoryId;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The date text needs the locale, which isn't available in initState
    final date = _selectedDate;
    if (date != null) {
      _dateController.text = date.toLocalizedString(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // Opens the date picker and writes the chosen date into the field,
  // formatted for the current language (e.g. 2026. nov. 21. / Nov 21, 2026)
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked == null || !mounted) return;

    setState(() {
      _selectedDate = picked;
      _dateController.text = picked.toLocalizedString(context);
    });
  }

  // Confirm dialog: true = leave without saving, false = stay
  Future<bool> _confirmDiscard() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.discardChangesTitle),
        content: Text(l10n.discardChangesMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.no),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.yes),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context);
    // Grab the messenger and navigator before the async gap
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final errorColor = Theme.of(context).colorScheme.error;
    final notifier = ref.read(todosProvider.notifier);

    setState(() => _saving = true);

    // Edit: same id and finished state, so update overwrites the row
    final todo = Todo(
      id: widget.todo?.id,
      isFinished: widget.todo?.isFinished ?? false,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      categoryId: _existingCategoryId(_selectedCategoryId)!,
      todoDate: _selectedDate,
    );

    // id == null: insert, otherwise update. The list on the home screen
    // is refreshed by todosProvider.
    final success = await notifier.save(todo);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(success ? l10n.todoSaved : l10n.todoSaveError),
          backgroundColor: success ? null : errorColor,
        ),
      );

    if (!mounted) return;
    if (success) {
      navigator.pop();
    } else {
      // Stay on the form so nothing typed is lost
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Cached by the provider: usually already loaded, no DB query here
    final categories = ref.watch(categoriesProvider).value;
    final noCategories = categories != null && categories.isEmpty;

    // Back button / gesture: ask first if something was changed.
    // The save itself pops with Navigator.pop, which PopScope doesn't block.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        if (_hasChanges && !await _confirmDiscard()) return;
        if (!context.mounted) return;
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditing ? l10n.editTodo : l10n.newTodo),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: l10n.title,
                  hintText: l10n.titleHint,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? l10n.titleRequired
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: l10n.description,
                  hintText: l10n.descriptionHint,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                // Not typed in: tapping the field opens the date picker
                readOnly: true,
                onTap: _pickDate,
                decoration: InputDecoration(
                  labelText: l10n.date,
                  hintText: l10n.dateHint,
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                // initialValue is only read when the field is created, so
                // recreate it once the categories have loaded (and an edited
                // todo's missing category may have been cleared)
                key: ValueKey(categories == null),
                initialValue: _existingCategoryId(_selectedCategoryId),
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: l10n.category,
                  border: const OutlineInputBorder(),
                ),
                hint: Text(l10n.selectCategory),
                // Shown when the dropdown is disabled (no categories yet)
                disabledHint: Text(noCategories ? l10n.noCategories : ''),
                items: categories
                    ?.map((category) => DropdownMenuItem<int>(
                          value: category.id!,
                          child: Text(category.name),
                        ))
                    .toList(),
                // null onChanged disables the dropdown while loading/empty
                onChanged: (categories == null || categories.isEmpty)
                    ? null
                    : (value) => setState(() => _selectedCategoryId = value),
                validator: (value) =>
                    value == null ? l10n.categoryNotSelected : null,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _saving ? null : _save,
                icon: const Icon(Icons.save),
                label: Text(l10n.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
