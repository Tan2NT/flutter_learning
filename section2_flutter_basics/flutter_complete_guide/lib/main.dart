import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import 'package:flutter_complete_guide/quiz.dart';

import './question.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppSate();
  }
}

class _MyAppSate extends State<MyApp> {
  var _selectingIndex = 0;
  var _totalScore = 0;

  var questions = const [
    {
      'questionText': 'What is your favorite color?',
      'answers': [
        {'text': 'yellow', 'score': 5},
        {'text': 'white', 'score': 7},
        {'text': 'red', 'score': 6},
      ]
    },
    {
      'questionText': 'What is your favorite animal?',
      'answers': [
        {'text': 'dog', 'score': 9},
        {'text': 'cat', 'score': 6},
        {'text': 'cat', 'score': 8},
      ]
    },
  ];

  void answerQuestion(int chosenIndex) {
    var selectedAnswer =
        (questions[_selectingIndex]['answers'] as List<Map<String, Object>>)
            .elementAt(chosenIndex);
    var addingScore = selectedAnswer['score'] as int;
    _totalScore += addingScore;
    print(
        'you chose ${selectedAnswer['text'] as String} has ${addingScore} score => total Score: ${_totalScore}');
    setState(() {
      _selectingIndex += 1;
      //(_selectingIndex < questions.length - 1) ? _selectingIndex + 1 : 0;
    });
  }

  void resetQuiz() {
    setState(() {
      _selectingIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var answerIndex = 0;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _selectingIndex < questions.length
            ? Quiz(questions[_selectingIndex], answerQuestion)
            : Result(_totalScore, resetQuiz),
      ),
    );
  }
}
