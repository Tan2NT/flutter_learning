import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final Map<String, Object> question;
  final void Function(int) selectHander;

  Quiz(this.question, this.selectHander);
  var answerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(question['questionText'].toString()),
        ...(question['answers'] as List<Map<String, Object>>).map((answer) {
          return Answer(answer['text'] as String, answerIndex++, selectHander);
        }).toList()
      ],
    );
  }
}
