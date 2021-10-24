import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import 'package:flutter_complete_guide/quiz.dart';

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

  var questions = const [
    {
      'questionText': 'What is your favorite color?',
      'answers': ['yellow', 'white', 'red']
    },
    {
      'questionText': 'What is your favorite animal?',
      'answers': ['dog', 'cat', 'mouse']
    },
  ];

  void answerQuestion(int chosenIndex) {
    print(
        'you chose ${(questions[_selectingIndex]['answers'] as List<String>).elementAt(chosenIndex)}');
    setState(() {
      _selectingIndex += 1;
      //(_selectingIndex < questions.length - 1) ? _selectingIndex + 1 : 0;
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
            : Center(
                child: Text('You did it!'),
              ),
      ),
    );
  }
}
