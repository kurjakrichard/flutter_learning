import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'note_detail.dart';
import '../services/database_helper.dart';
import '../models/note.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;
  List<Note>? noteList;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = <Note>[];
      updateListView();
    }

    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notes),
      ),
      body: getNoteListView(context),
      floatingActionButton: FloatingActionButton(
        tooltip: l10n.addNote,
        onPressed: () {
          debugPrint('Add item clicked');
          navigatetoDetail(l10n.addNote,Note('', '', 0, ''), );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.titleMedium!;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        getPriorityColor(noteList![position].priority),
                    child: getPriorityIcon(noteList![position].priority),
                  ),
                  title: Text(
                    noteList![position].title,
                    style: titleStyle,
                  ),
                  subtitle: Text(noteList![position].date),
                  trailing: GestureDetector(
                    child: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      debugPrint('Delete icon clicked');
                      _delete(context, noteList![position]);
                    },
                  ),
                  onTap: () {
                    debugPrint('Edit note ${noteList![position].description}');
                    navigatetoDetail(AppLocalizations.of(context).editNote,noteList![position],
                        );
                  }));
        });
  }

  void navigatetoDetail(String title, Note note ) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return NoteDetail(note, title);
        },
      ),
    );

    if (result == true) {
      updateListView();
    }
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 0:
        return Colors.yellow;
      default:
        return Colors.yellow;
    }
  }

  // Returns the priority
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return const Icon(Icons.play_arrow);
      case 0:
        return const Icon(Icons.keyboard_arrow_right);
      default:
        return const Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    debugPrint(result.toString());
    if (result != 0) {
      if (!context.mounted) return;
      _showSnackBar(AppLocalizations.of(context).noteDeleted, context);
      updateListView();
    }
  }

  void _showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.database;
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          count = noteList.length;
        });
      });
    });
  }
}
