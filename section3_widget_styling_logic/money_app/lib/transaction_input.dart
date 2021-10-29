import 'package:flutter/material.dart';

import './transaction.dart';

class TransactionInput extends StatefulWidget {
  void Function(Transaction) _addTransactionHandler;

  TransactionInput(this._addTransactionHandler);

  void onSubmitted(String title, String amount) {
    if (title.isEmpty || amount.isEmpty) return;

    _addTransactionHandler(Transaction(
        DateTime.now().microsecondsSinceEpoch.toString(),
        title,
        double.parse(amount),
        DateTime.now()));
  }

  @override
  _TransactionInputState createState() => _TransactionInputState(onSubmitted);
}

class _TransactionInputState extends State<TransactionInput> {
  void Function(String, String) _onSubmitted;

  _TransactionInputState(this._onSubmitted);

  final titleControler = TextEditingController();
  final amountControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleControler,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountControler,
            ),
            FlatButton(
                child: Text('Add transaction'),
                onPressed: () {
                  _onSubmitted(titleControler.text, amountControler.text);
                })
          ],
        ),
      ),
    );
  }
}
