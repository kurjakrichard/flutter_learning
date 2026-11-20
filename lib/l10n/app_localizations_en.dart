// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Learning';

  @override
  String get menuTitle => 'Flutter Learning Menu';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'System default';

  @override
  String get languageHungarian => 'Magyar';

  @override
  String get languageEnglish => 'English';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get date => 'Date';

  @override
  String get status => 'Status';

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get categories => 'Categories';

  @override
  String get newCategory => 'New category';

  @override
  String get editCategory => 'Edit category';

  @override
  String get category => 'Category';

  @override
  String get categoryHint => 'Write a category';

  @override
  String get descriptionHint => 'Write a description';

  @override
  String get todoListEmpty => 'List has no data';

  @override
  String get addTodo => 'Add Todo';

  @override
  String get insert => 'Insert';

  @override
  String get quizTitle => 'First app';

  @override
  String get quizFinished => 'No more questions!';

  @override
  String get quizQuestionWho => 'Who are you?';

  @override
  String get quizQuestionWhere => 'Where are you?';

  @override
  String get quizQuestionBorn => 'Where were you born?';

  @override
  String get quizAnswerPooh => 'Winnie the Pooh';

  @override
  String get quizAnswerSnowWhite => 'Snow White';

  @override
  String get quizAnswerPapaSmurf => 'Papa Smurf';

  @override
  String get quizAnswerHome => 'at home';

  @override
  String get quizAnswerShop => 'in a shop';

  @override
  String get quizAnswerWork => 'at work';

  @override
  String get quizAnswerBalaton => 'at Lake Balaton';

  @override
  String get button => 'Button';

  @override
  String get goodFlight => 'Have a good flight';

  @override
  String get landscape => 'Landscape';

  @override
  String get beautiful => 'Beautiful';

  @override
  String get sampleText => 'text';

  @override
  String listItem(int index) {
    return 'Item $index';
  }

  @override
  String get snackbarText => 'This is a snackbar';

  @override
  String get statefulExample => 'Stateful app example';

  @override
  String bestCity(String city) {
    return 'Your best city is $city';
  }

  @override
  String bestCountry(String country) {
    return 'Your best country is $country';
  }

  @override
  String get currencyForint => 'Forint';

  @override
  String get currencyDollar => 'Dollar';

  @override
  String get currencyEuro => 'Euro';

  @override
  String get currencyOther => 'Other';

  @override
  String get interestCalculator => 'Interest calculator';

  @override
  String get investment => 'Principal';

  @override
  String get investmentHint => 'Enter the principal amount, e.g. 1,000,000';

  @override
  String get interestRate => 'Rate of interest';

  @override
  String get interestRateHint => 'In percent';

  @override
  String get period => 'Term';

  @override
  String get periodHint => 'Term in years';

  @override
  String get calculate => 'Calculate';

  @override
  String get reset => 'Reset';

  @override
  String get enterNumber => 'Please enter a number!';

  @override
  String interestResult(String term, String amount, String currency) {
    return 'After $term years your investment will be worth $amount $currency.';
  }

  @override
  String get notes => 'Notes';

  @override
  String get addNote => 'Add note';

  @override
  String get editNote => 'Edit note';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityLow => 'Low';

  @override
  String get noteSaved => 'Note saved successfully';

  @override
  String get noteSaveError => 'Problem saving note';

  @override
  String get noteDeleted => 'Note deleted successfully';

  @override
  String get noteDeleteError => 'Error occurred while deleting note';

  @override
  String get noNoteDeleted => 'No note was deleted';

  @override
  String get discardChangesTitle => 'Are you sure you want to leave?';

  @override
  String get discardChangesMessage => 'Unsaved changes will be lost.';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';
}
