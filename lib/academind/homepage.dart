import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import 'package:flutter_learning/academind/answer.dart';
import 'package:flutter_learning/academind/question.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final questions = <Map<String, Object>>[
      {
        'question': l10n.quizQuestionWho,
        'answers': [
          l10n.quizAnswerPooh,
          l10n.quizAnswerSnowWhite,
          l10n.quizAnswerPapaSmurf,
        ]
      },
      {
        'question': l10n.quizQuestionWhere,
        'answers': [
          l10n.quizAnswerHome,
          l10n.quizAnswerShop,
          l10n.quizAnswerWork,
          l10n.quizAnswerBalaton,
        ]
      },
      {
        'question': l10n.quizQuestionBorn,
        'answers': ['Hatvan', 'Budapest', 'Ecséd']
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.quizTitle),
      ),
      body: _questionIndex < questions.length
          ? Column(
              children: [
                Question(
                    questionText:
                        questions[_questionIndex]['question'] as String),
                ...(questions[_questionIndex]['answers'] as List<String>)
                    .map(
                      (answer) => Answer(
                        onTap: _onAnswer,
                        answer: answer,
                      ),
                    )
                    .toList(), // toList not necessiary
              ],
            )
          : Center(
              child: Text(
                l10n.quizFinished,
                style: const TextStyle(fontSize: 28),
              ),
            ),
    );
  }

  void _onAnswer() {
    setState(() {
      _questionIndex++;
    });

    // ignore: avoid_print
    print(_questionIndex.toString());
    // ignore: avoid_print
    print('Answer1');
  }
}
