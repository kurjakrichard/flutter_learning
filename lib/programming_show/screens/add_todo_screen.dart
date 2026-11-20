import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_learning/programming_show/model/todo.dart';
import 'package:flutter_learning/programming_show/provider/todo_provider.dart';

class AddTodoScreen extends ConsumerStatefulWidget {
  const AddTodoScreen({super.key});

  @override
  ConsumerState<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends ConsumerState<AddTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addTodo),
      ),
      body: ListView(
        children: [
          textController(l10n.title, _titleController),
          textController(l10n.description, _descriptionController),
          textController(l10n.date, _dateController),
          ElevatedButton(
              onPressed: () {
                Todo todo = Todo(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    date: _dateController.text);
                ref.read(todoProvider.notifier).insertTodo(todo);
                clerControllers();
                Navigator.pop(context);
              },
              child: Text(l10n.insert))
        ],
      ),
    );
  }

  void clerControllers() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
  }

  Widget textController(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(), hintText: title),
      ),
    );
  }
}
