import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Az alkalmazásban választható nyelvek.
/// A [system] a készülék nyelvét követi.
enum AppLanguage {
  system(null),
  hu(Locale('hu')),
  en(Locale('en'));

  const AppLanguage(this.locale);

  final Locale? locale;
}

/// A main()-ben felülírjuk a már betöltött példánnyal.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider not overridden'),
);

final appLanguageProvider =
    NotifierProvider<AppLanguageNotifier, AppLanguage>(AppLanguageNotifier.new);

class AppLanguageNotifier extends Notifier<AppLanguage> {
  static const _prefsKey = 'app_language';

  @override
  AppLanguage build() {
    final saved = ref.read(sharedPreferencesProvider).getString(_prefsKey);
    return AppLanguage.values.firstWhere(
      (lang) => lang.name == saved,
      orElse: () => AppLanguage.system,
    );
  }

  Future<void> setLanguage(AppLanguage language) async {
    state = language;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_prefsKey, language.name);
  }
}
