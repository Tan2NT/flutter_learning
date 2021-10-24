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
    'What is your favorite color?',
    'What is your favorite animal'
  ];

  void answerQuestion(var chosenIndex) {
    setState(() {
      selectingIndex =
          (selectingIndex < questions.length - 1) ? selectingIndex + 1 : 0;
    });
    print('Answer ${chosenIndex} is chosen!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Column(
          children: [
            Text(questions.elementAt(selectingIndex)),
            RaisedButton(
              child: Text('Answer 1'),
              onPressed: () => answerQuestion(1),
            ),
            RaisedButton(
              child: Text('Answer 2'),
              onPressed: () => answerQuestion(2),
            ),
          ],
        ),
      ),
    );
  }
}
