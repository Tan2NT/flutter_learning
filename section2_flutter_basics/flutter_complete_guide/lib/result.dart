import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final void Function() resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    var resultText = "Your Score: ${resultScore} \n";
    if (resultScore > 14) {
      resultText += "You are awesome!!!";
    } else
      resultText += "Pretty likeable!!";
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 28, color: Colors.blue),
          ),
          FlatButton(
              onPressed: resetHandler,
              child: Text('re-try',
                  style: TextStyle(fontSize: 18, color: Colors.redAccent)))
        ],
      ),
    );
  }
}
