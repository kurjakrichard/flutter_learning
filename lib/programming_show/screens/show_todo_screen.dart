import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_learning/programming_show/provider/todo_provider.dart';
import 'package:flutter_learning/programming_show/screens/add_todo_screen.dart';

class ShowTodoScreen extends ConsumerWidget {
  const ShowTodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Programming show')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddTodoScreen()));
        },
      ),
      body: todos.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.errorMessage('$e'))),
        data: (items) => items.isEmpty
            ? Center(
                child: Text(
                l10n.todoListEmpty,
                style: const TextStyle(fontSize: 35, color: Colors.black),
              ))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => Card(
                  elevation: 5,
                  child: ListTile(
                    style: ListTileStyle.drawer,
                    title: Text(items[index].title),
                    subtitle: Text(items[index].description ?? ''),
                    trailing: Text(items[index].date),
                  ),
                ),
              ),
      ),
    );
  }
}
