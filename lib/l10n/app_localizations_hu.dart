// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'Flutter tanulás';

  @override
  String get menuTitle => 'Flutter tanulás menü';

  @override
  String get home => 'Kezdőlap';

  @override
  String get settings => 'Beállítások';

  @override
  String get language => 'Nyelv';

  @override
  String get languageSystem => 'Rendszer nyelve';

  @override
  String get languageHungarian => 'Magyar';

  @override
  String get languageEnglish => 'English';

  @override
  String get save => 'Mentés';

  @override
  String get cancel => 'Mégse';

  @override
  String get delete => 'Törlés';

  @override
  String get title => 'Cím';

  @override
  String get description => 'Leírás';

  @override
  String get date => 'Dátum';

  @override
  String get status => 'Állapot';

  @override
  String errorMessage(String error) {
    return 'Hiba: $error';
  }

  @override
  String get categories => 'Kategóriák';

  @override
  String get newCategory => 'Új kategória';

  @override
  String get editCategory => 'Kategória szerkesztése';

  @override
  String get category => 'Kategória';

  @override
  String get categoryHint => 'Írj be egy kategóriát';

  @override
  String get descriptionHint => 'Írj be egy leírást';

  @override
  String get todoListEmpty => 'A lista üres';

  @override
  String get addTodo => 'Új teendő';

  @override
  String get insert => 'Hozzáadás';

  @override
  String get quizTitle => 'Első program';

  @override
  String get quizFinished => 'Vége a kérdéseknek!';

  @override
  String get quizQuestionWho => 'Ki vagy?';

  @override
  String get quizQuestionWhere => 'Hol vagy?';

  @override
  String get quizQuestionBorn => 'Hol születtél?';

  @override
  String get quizAnswerPooh => 'Micimackó';

  @override
  String get quizAnswerSnowWhite => 'Hófehérke';

  @override
  String get quizAnswerPapaSmurf => 'Törpapa';

  @override
  String get quizAnswerHome => 'otthon';

  @override
  String get quizAnswerShop => 'boltban';

  @override
  String get quizAnswerWork => 'munkahelyen';

  @override
  String get quizAnswerBalaton => 'Balaton';

  @override
  String get button => 'Gomb';

  @override
  String get goodFlight => 'Jó utat!';

  @override
  String get landscape => 'Tájkép';

  @override
  String get beautiful => 'Gyönyörű';

  @override
  String get sampleText => 'szöveg';

  @override
  String listItem(int index) {
    return 'Elem $index';
  }

  @override
  String get snackbarText => 'Ez egy snackbar';

  @override
  String get statefulExample => 'Állapotkezelő példa';

  @override
  String bestCity(String city) {
    return 'A kedvenc városod: $city';
  }

  @override
  String bestCountry(String country) {
    return 'A kedvenc országod: $country';
  }

  @override
  String get currencyForint => 'Forint';

  @override
  String get currencyDollar => 'Dollár';

  @override
  String get currencyEuro => 'Euró';

  @override
  String get currencyOther => 'Egyéb';

  @override
  String get interestCalculator => 'Kamatkalkulátor';

  @override
  String get investment => 'Befektetés';

  @override
  String get investmentHint => 'Add meg a befektetés összegét, pl.: 1.000.000';

  @override
  String get interestRate => 'Kamatráta';

  @override
  String get interestRateHint => '%-ban';

  @override
  String get period => 'Időszak';

  @override
  String get periodHint => 'Időszak években';

  @override
  String get calculate => 'Számol';

  @override
  String get reset => 'Nulláz';

  @override
  String get enterNumber => 'Kérlek, számot adj meg!';

  @override
  String interestResult(String term, String amount, String currency) {
    return '$term év múlva a befektetésed értéke $amount $currency lesz.';
  }

  @override
  String get notes => 'Jegyzetek';

  @override
  String get addNote => 'Új jegyzet';

  @override
  String get editNote => 'Jegyzet szerkesztése';

  @override
  String get priorityHigh => 'Magas';

  @override
  String get priorityLow => 'Alacsony';

  @override
  String get noteSaved => 'A jegyzet mentve';

  @override
  String get noteSaveError => 'Hiba történt a jegyzet mentésekor';

  @override
  String get noteDeleted => 'A jegyzet törölve';

  @override
  String get noteDeleteError => 'Hiba történt a jegyzet törlésekor';

  @override
  String get noNoteDeleted => 'Nem történt törlés';

  @override
  String get discardChangesTitle => 'Biztos kilépsz?';

  @override
  String get discardChangesMessage => 'A nem mentett módosítások elvesznek.';

  @override
  String get yes => 'Igen';

  @override
  String get no => 'Nem';
}
