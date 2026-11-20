import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import 'package:flutter_learning/settings/settings_tile.dart';
import 'categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todolist Sqflite'),
      ),
      drawer: drawerWidget(),
      body: Container(),
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
            title: Text(l10n.home),
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
