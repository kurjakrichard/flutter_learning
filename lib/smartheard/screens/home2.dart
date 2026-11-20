import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';

class Home2 extends StatelessWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('bookpilot'),
      ),
      body: getListView(context),
    );
  }

  Widget getListView(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.landscape),
          title: Text(l10n.landscape),
          subtitle: Text(l10n.beautiful),
          trailing: const Icon(Icons.wb_sunny),
          onTap: () {
            debugPrint('print');
          },
        ),
        ListTile(
          leading: const Icon(Icons.landscape),
          title: Text(l10n.landscape),
          subtitle: Text(l10n.beautiful),
          trailing: const Icon(Icons.wb_sunny),
          onTap: () {
            debugPrint('print2');
          },
        ),
        Text(l10n.sampleText)
      ],
    );
  }
}
