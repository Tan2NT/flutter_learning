import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';

import './question.dart';

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
  var questions = [
    ['What is your favorite color?', 'yellow', 'white', 'red'],
    ['What is your favorite animal', 'dog', 'cat', 'mouse']
  ];

  void answerQuestion(int chosenIndex) {
    print(
        'Your chose ${questions.elementAt(_selectingIndex).elementAt(chosenIndex)}!');
    setState(() {
      _selectingIndex =
          (_selectingIndex < questions.length - 1) ? _selectingIndex + 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedQuestion = questions.elementAt(_selectingIndex);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Column(
          children: [
            Question(selectedQuestion.elementAt(0)),
            Answer(selectedQuestion.elementAt(1), 1, answerQuestion),
            Answer(selectedQuestion.elementAt(2), 2, answerQuestion),
            Answer(selectedQuestion.elementAt(3), 3, answerQuestion),
          ],
        ),
      ),
    );
  }
}
