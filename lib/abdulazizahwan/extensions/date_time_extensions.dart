import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

// Named, so other files can import it (an unnamed extension is only
// visible in the file it's declared in)
extension DateTimeFormatting on DateTime {
  /// Short date in the app's current language,
  /// e.g. "2026. nov. 21." (hu) / "Nov 21, 2026" (en)
  String toLocalizedString(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat.yMMMd(locale).format(this);
  }
}
