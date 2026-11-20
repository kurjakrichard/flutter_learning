import 'package:flutter_learning/l10n/app_localizations.dart';

enum Currency {
  forint,
  dollar,
  euro,
  other;

  String label(AppLocalizations l10n) => switch (this) {
        Currency.forint => l10n.currencyForint,
        Currency.dollar => l10n.currencyDollar,
        Currency.euro => l10n.currencyEuro,
        Currency.other => l10n.currencyOther,
      };
}
