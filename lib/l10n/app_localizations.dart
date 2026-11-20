import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hu')
  ];

  /// No description provided for @appTitle.
  ///
  /// In hu, this message translates to:
  /// **'Flutter tanulás'**
  String get appTitle;

  /// No description provided for @menuTitle.
  ///
  /// In hu, this message translates to:
  /// **'Flutter tanulás menü'**
  String get menuTitle;

  /// No description provided for @home.
  ///
  /// In hu, this message translates to:
  /// **'Kezdőlap'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In hu, this message translates to:
  /// **'Beállítások'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In hu, this message translates to:
  /// **'Nyelv'**
  String get language;

  /// No description provided for @languageSystem.
  ///
  /// In hu, this message translates to:
  /// **'Rendszer nyelve'**
  String get languageSystem;

  /// No description provided for @languageHungarian.
  ///
  /// In hu, this message translates to:
  /// **'Magyar'**
  String get languageHungarian;

  /// No description provided for @languageEnglish.
  ///
  /// In hu, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @save.
  ///
  /// In hu, this message translates to:
  /// **'Mentés'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In hu, this message translates to:
  /// **'Mégse'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In hu, this message translates to:
  /// **'Törlés'**
  String get delete;

  /// No description provided for @title.
  ///
  /// In hu, this message translates to:
  /// **'Cím'**
  String get title;

  /// No description provided for @description.
  ///
  /// In hu, this message translates to:
  /// **'Leírás'**
  String get description;

  /// No description provided for @date.
  ///
  /// In hu, this message translates to:
  /// **'Dátum'**
  String get date;

  /// No description provided for @status.
  ///
  /// In hu, this message translates to:
  /// **'Állapot'**
  String get status;

  /// No description provided for @errorMessage.
  ///
  /// In hu, this message translates to:
  /// **'Hiba: {error}'**
  String errorMessage(String error);

  /// No description provided for @categories.
  ///
  /// In hu, this message translates to:
  /// **'Kategóriák'**
  String get categories;

  /// No description provided for @newCategory.
  ///
  /// In hu, this message translates to:
  /// **'Új kategória'**
  String get newCategory;

  /// No description provided for @editCategory.
  ///
  /// In hu, this message translates to:
  /// **'Kategória szerkesztése'**
  String get editCategory;

  /// No description provided for @category.
  ///
  /// In hu, this message translates to:
  /// **'Kategória'**
  String get category;

  /// No description provided for @categoryHint.
  ///
  /// In hu, this message translates to:
  /// **'Írj be egy kategóriát'**
  String get categoryHint;

  /// No description provided for @descriptionHint.
  ///
  /// In hu, this message translates to:
  /// **'Írj be egy leírást'**
  String get descriptionHint;

  /// No description provided for @todoListEmpty.
  ///
  /// In hu, this message translates to:
  /// **'A lista üres'**
  String get todoListEmpty;

  /// No description provided for @addTodo.
  ///
  /// In hu, this message translates to:
  /// **'Új teendő'**
  String get addTodo;

  /// No description provided for @insert.
  ///
  /// In hu, this message translates to:
  /// **'Hozzáadás'**
  String get insert;

  /// No description provided for @quizTitle.
  ///
  /// In hu, this message translates to:
  /// **'Első program'**
  String get quizTitle;

  /// No description provided for @quizFinished.
  ///
  /// In hu, this message translates to:
  /// **'Vége a kérdéseknek!'**
  String get quizFinished;

  /// No description provided for @quizQuestionWho.
  ///
  /// In hu, this message translates to:
  /// **'Ki vagy?'**
  String get quizQuestionWho;

  /// No description provided for @quizQuestionWhere.
  ///
  /// In hu, this message translates to:
  /// **'Hol vagy?'**
  String get quizQuestionWhere;

  /// No description provided for @quizQuestionBorn.
  ///
  /// In hu, this message translates to:
  /// **'Hol születtél?'**
  String get quizQuestionBorn;

  /// No description provided for @quizAnswerPooh.
  ///
  /// In hu, this message translates to:
  /// **'Micimackó'**
  String get quizAnswerPooh;

  /// No description provided for @quizAnswerSnowWhite.
  ///
  /// In hu, this message translates to:
  /// **'Hófehérke'**
  String get quizAnswerSnowWhite;

  /// No description provided for @quizAnswerPapaSmurf.
  ///
  /// In hu, this message translates to:
  /// **'Törpapa'**
  String get quizAnswerPapaSmurf;

  /// No description provided for @quizAnswerHome.
  ///
  /// In hu, this message translates to:
  /// **'otthon'**
  String get quizAnswerHome;

  /// No description provided for @quizAnswerShop.
  ///
  /// In hu, this message translates to:
  /// **'boltban'**
  String get quizAnswerShop;

  /// No description provided for @quizAnswerWork.
  ///
  /// In hu, this message translates to:
  /// **'munkahelyen'**
  String get quizAnswerWork;

  /// No description provided for @quizAnswerBalaton.
  ///
  /// In hu, this message translates to:
  /// **'Balaton'**
  String get quizAnswerBalaton;

  /// No description provided for @button.
  ///
  /// In hu, this message translates to:
  /// **'Gomb'**
  String get button;

  /// No description provided for @goodFlight.
  ///
  /// In hu, this message translates to:
  /// **'Jó utat!'**
  String get goodFlight;

  /// No description provided for @landscape.
  ///
  /// In hu, this message translates to:
  /// **'Tájkép'**
  String get landscape;

  /// No description provided for @beautiful.
  ///
  /// In hu, this message translates to:
  /// **'Gyönyörű'**
  String get beautiful;

  /// No description provided for @sampleText.
  ///
  /// In hu, this message translates to:
  /// **'szöveg'**
  String get sampleText;

  /// No description provided for @listItem.
  ///
  /// In hu, this message translates to:
  /// **'Elem {index}'**
  String listItem(int index);

  /// No description provided for @snackbarText.
  ///
  /// In hu, this message translates to:
  /// **'Ez egy snackbar'**
  String get snackbarText;

  /// No description provided for @statefulExample.
  ///
  /// In hu, this message translates to:
  /// **'Állapotkezelő példa'**
  String get statefulExample;

  /// No description provided for @bestCity.
  ///
  /// In hu, this message translates to:
  /// **'A kedvenc városod: {city}'**
  String bestCity(String city);

  /// No description provided for @bestCountry.
  ///
  /// In hu, this message translates to:
  /// **'A kedvenc országod: {country}'**
  String bestCountry(String country);

  /// No description provided for @currencyForint.
  ///
  /// In hu, this message translates to:
  /// **'Forint'**
  String get currencyForint;

  /// No description provided for @currencyDollar.
  ///
  /// In hu, this message translates to:
  /// **'Dollár'**
  String get currencyDollar;

  /// No description provided for @currencyEuro.
  ///
  /// In hu, this message translates to:
  /// **'Euró'**
  String get currencyEuro;

  /// No description provided for @currencyOther.
  ///
  /// In hu, this message translates to:
  /// **'Egyéb'**
  String get currencyOther;

  /// No description provided for @interestCalculator.
  ///
  /// In hu, this message translates to:
  /// **'Kamatkalkulátor'**
  String get interestCalculator;

  /// No description provided for @investment.
  ///
  /// In hu, this message translates to:
  /// **'Befektetés'**
  String get investment;

  /// No description provided for @investmentHint.
  ///
  /// In hu, this message translates to:
  /// **'Add meg a befektetés összegét, pl.: 1.000.000'**
  String get investmentHint;

  /// No description provided for @interestRate.
  ///
  /// In hu, this message translates to:
  /// **'Kamatráta'**
  String get interestRate;

  /// No description provided for @interestRateHint.
  ///
  /// In hu, this message translates to:
  /// **'%-ban'**
  String get interestRateHint;

  /// No description provided for @period.
  ///
  /// In hu, this message translates to:
  /// **'Időszak'**
  String get period;

  /// No description provided for @periodHint.
  ///
  /// In hu, this message translates to:
  /// **'Időszak években'**
  String get periodHint;

  /// No description provided for @calculate.
  ///
  /// In hu, this message translates to:
  /// **'Számol'**
  String get calculate;

  /// No description provided for @reset.
  ///
  /// In hu, this message translates to:
  /// **'Nulláz'**
  String get reset;

  /// No description provided for @enterNumber.
  ///
  /// In hu, this message translates to:
  /// **'Kérlek, számot adj meg!'**
  String get enterNumber;

  /// No description provided for @interestResult.
  ///
  /// In hu, this message translates to:
  /// **'{term} év múlva a befektetésed értéke {amount} {currency} lesz.'**
  String interestResult(String term, String amount, String currency);

  /// No description provided for @notes.
  ///
  /// In hu, this message translates to:
  /// **'Jegyzetek'**
  String get notes;

  /// No description provided for @addNote.
  ///
  /// In hu, this message translates to:
  /// **'Új jegyzet'**
  String get addNote;

  /// No description provided for @editNote.
  ///
  /// In hu, this message translates to:
  /// **'Jegyzet szerkesztése'**
  String get editNote;

  /// No description provided for @priorityHigh.
  ///
  /// In hu, this message translates to:
  /// **'Magas'**
  String get priorityHigh;

  /// No description provided for @priorityLow.
  ///
  /// In hu, this message translates to:
  /// **'Alacsony'**
  String get priorityLow;

  /// No description provided for @noteSaved.
  ///
  /// In hu, this message translates to:
  /// **'A jegyzet mentve'**
  String get noteSaved;

  /// No description provided for @noteSaveError.
  ///
  /// In hu, this message translates to:
  /// **'Hiba történt a jegyzet mentésekor'**
  String get noteSaveError;

  /// No description provided for @noteDeleted.
  ///
  /// In hu, this message translates to:
  /// **'A jegyzet törölve'**
  String get noteDeleted;

  /// No description provided for @noteDeleteError.
  ///
  /// In hu, this message translates to:
  /// **'Hiba történt a jegyzet törlésekor'**
  String get noteDeleteError;

  /// No description provided for @noNoteDeleted.
  ///
  /// In hu, this message translates to:
  /// **'Nem történt törlés'**
  String get noNoteDeleted;

  /// No description provided for @discardChangesTitle.
  ///
  /// In hu, this message translates to:
  /// **'Biztos kilépsz?'**
  String get discardChangesTitle;

  /// No description provided for @discardChangesMessage.
  ///
  /// In hu, this message translates to:
  /// **'A nem mentett módosítások elvesznek.'**
  String get discardChangesMessage;

  /// No description provided for @yes.
  ///
  /// In hu, this message translates to:
  /// **'Igen'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In hu, this message translates to:
  /// **'Nem'**
  String get no;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hu'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hu':
      return AppLocalizationsHu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
