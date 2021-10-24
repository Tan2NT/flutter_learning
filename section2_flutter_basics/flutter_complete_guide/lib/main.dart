import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppSate();
  }
}

class MyAppSate extends State<MyApp> {
  var selectingIndex = 0;
  var questions = [
    ['What is your favorite color?', 'yellow', 'white', 'red'],
    ['What is your favorite animal', 'dog', 'cat', 'mouse']
  ];

  void answerQuestion(var chosenIndex) {
    print(
        'Your chose ${questions.elementAt(selectingIndex).elementAt(chosenIndex)}!');
    setState(() {
      selectingIndex =
          (selectingIndex < questions.length - 1) ? selectingIndex + 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedQuestion = questions.elementAt(selectingIndex);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Column(
          children: [
            Text(selectedQuestion.elementAt(0)),
            RaisedButton(
              child: Text(selectedQuestion.elementAt(1)),
              onPressed: () => answerQuestion(1),
            ),
            RaisedButton(
              child: Text(selectedQuestion.elementAt(2)),
              onPressed: () => answerQuestion(2),
            ),
            RaisedButton(
              child: Text(selectedQuestion.elementAt(3)),
              onPressed: () => answerQuestion(3),
            ),
          ],
        ),
      ),
    );
  }
}
