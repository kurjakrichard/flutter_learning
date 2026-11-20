import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import 'package:flutter_learning/settings/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final current = ref.watch(appLanguageProvider);

    String label(AppLanguage lang) => switch (lang) {
          AppLanguage.system => l10n.languageSystem,
          AppLanguage.hu => l10n.languageHungarian,
          AppLanguage.en => l10n.languageEnglish,
        };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(
              l10n.language,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          RadioGroup<AppLanguage>(
            groupValue: current,
            onChanged: (lang) {
              if (lang != null) {
                ref.read(appLanguageProvider.notifier).setLanguage(lang);
              }
            },
            child: Column(
              children: [
                for (final lang in AppLanguage.values)
                  RadioListTile<AppLanguage>(
                    value: lang,
                    title: Text(label(lang)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
