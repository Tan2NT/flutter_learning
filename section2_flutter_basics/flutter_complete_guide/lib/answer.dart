import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final int answerIndex;
  final void Function(int) selectHandler;

  Answer(this.answerText, this.answerIndex, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.yellow,
        child: Text(answerText),
        onPressed: () => selectHandler(answerIndex),
      ),
    );
  }
}
