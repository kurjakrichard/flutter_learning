import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import 'home.dart';
import 'home2.dart';
import 'home3.dart';
import 'home4.dart';
import 'interest_calculator.dart';
import 'note_list.dart';

class SmartheardMenu extends StatelessWidget {
  const SmartheardMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = <String, Widget>{
      l10n.notes: const NoteList(),
      l10n.interestCalculator: const InterestCalculator(),
      'Home': const Home(),
      'Home 2': const Home2(),
      'Home 3': const Home3(),
      'Home 4': const Home4(),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Smartheard')),
      body: ListView(
        children: [
          for (final e in items.entries)
            ListTile(
              title: Text(e.key),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => e.value)),
            ),
        ],
      ),
    );
  }
}
