import 'package:flutter/material.dart';

import './transaction.dart';

class TransactionInput extends StatelessWidget {
  void Function(Transaction) _addTransactionHandler;

  TransactionInput(this._addTransactionHandler);

  @override
  Widget build(BuildContext context) {
    final titleControler = TextEditingController();
    final amountControler = TextEditingController();
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
                  _addTransactionHandler(Transaction(
                      DateTime.now().microsecondsSinceEpoch.toString(),
                      titleControler.text,
                      double.parse(amountControler.text),
                      DateTime.now()));
                })
          ],
        ),
      ),
    );
  }
}
