import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import 'package:flutter_learning/settings/settings_screen.dart';

/// Drawerbe tehető menüpont, ami megnyitja a Beállítások képernyőt.
class SettingsTile extends StatelessWidget {
  const SettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.settings),
      title: Text(AppLocalizations.of(context).settings),
      onTap: () {
        Navigator.pop(context); // drawer bezárása
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
      },
    );
  }
}
