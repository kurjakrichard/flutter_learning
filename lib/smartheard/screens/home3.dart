import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';

class Home3 extends StatelessWidget {
  const Home3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('bookpilot'),
      ),
      body: getListView(context),
    );
  }

  Widget getListView(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    var items = List<String>.generate(1000, (index) => l10n.listItem(index));

    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.arrow_back),
            title: Text(items[index]),
            onTap: () {
              var snackBar = SnackBar(
                content: Text(l10n.snackbarText),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              debugPrint('${items[index]} was tapped');
            },
          );
        });
  }
}
