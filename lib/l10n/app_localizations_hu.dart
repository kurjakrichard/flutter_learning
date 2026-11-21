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
  String get mainMenu => 'Főmenü';

  @override
  String get todos => 'Teendők';

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
  String get categoryRequired => 'A kategória neve nem lehet üres';

  @override
  String get categorySaved => 'A kategória mentése sikerült';

  @override
  String get categorySaveError => 'Hiba történt a kategória mentésekor';

  @override
  String get categoryDeleted => 'A kategória törölve';

  @override
  String get categoryDeleteError => 'Hiba történt a kategória törlésekor';

  @override
  String get deleteCategoryTitle => 'Biztos törlöd?';

  @override
  String deleteCategoryMessage(String name) {
    return 'A(z) „$name” kategória törlődik.';
  }

  @override
  String get undo => 'Visszavonás';

  @override
  String get categoryRestored => 'A kategória visszaállítva';

  @override
  String get categoryRestoreError =>
      'Hiba történt a kategória visszaállításakor';

  @override
  String get descriptionHint => 'Írj be egy leírást';

  @override
  String get titleHint => 'Írj be egy címet';

  @override
  String get dateHint => 'Válassz egy dátumot';

  @override
  String get selectCategory => 'Válassz kategóriát';

  @override
  String get noCategories => 'Még nincs kategória, előbb vegyél fel egyet';

  @override
  String get categoryNotSelected => 'Válassz egy kategóriát';

  @override
  String get titleRequired => 'A cím nem lehet üres';

  @override
  String get todoSaved => 'A teendő mentése sikerült';

  @override
  String get todoSaveError => 'Hiba történt a teendő mentésekor';

  @override
  String get newTodo => 'Új teendő';

  @override
  String get editTodo => 'Teendő szerkesztése';

  @override
  String get filterByCategory => 'Szűrés kategóriára';

  @override
  String get allCategories => 'Összes kategória';

  @override
  String get noTodosInCategory => 'Ebben a kategóriában nincs teendő';

  @override
  String get deleteTodoTitle => 'Biztos törlöd?';

  @override
  String deleteTodoMessage(String title) {
    return 'A(z) „$title” teendő törlődik.';
  }

  @override
  String get todoDeleted => 'A teendő törölve';

  @override
  String get todoDeleteError => 'Hiba történt a teendő törlésekor';

  @override
  String get todoRestored => 'A teendő visszaállítva';

  @override
  String get todoRestoreError => 'Hiba történt a teendő visszaállításakor';

  @override
  String get todoUpdateError => 'Hiba történt a teendő módosításakor';

  @override
  String get todoListEmpty => 'A lista üres';

  @override
  String get loadError => 'Hiba történt a betöltéskor';

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
