import 'package:flutter/material.dart';
import 'package:flutter_learning/abdulazizahwan/screens/homescreen.dart';
import 'package:flutter_learning/academind/homepage.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import 'package:flutter_learning/settings/settings_tile.dart';
import 'package:flutter_learning/smartheard/screens/smartheard_menu.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.menuTitle),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  l10n.appTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            const SettingsTile(),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MenuButton(
              label: 'Academind',
              destination: HomePage(),
            ),
            MenuButton(
              label: 'Abdulaziz Ahwan',
              destination: HomeScreen(),
            ),
            MenuButton(
              label: 'Smartheard',
              destination: SmartheardMenu(),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.label,
    required this.destination,
  });

  final String label;
  final Widget destination;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FilledButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => destination)),
        child: Text(label),
      ),
    );
  }
}
