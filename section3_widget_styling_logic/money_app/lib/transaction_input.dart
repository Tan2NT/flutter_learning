import 'dart:ffi';
import 'package:flutter/material.dart';

import './transaction.dart';

class TransactionInput extends StatefulWidget {
  void Function(Transaction) _addTransactionHandler;

  TransactionInput(this._addTransactionHandler);

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final titleControler = TextEditingController();

  final amountControler = TextEditingController();

  void submitData() {
    String title = titleControler.text;
    String amount = amountControler.text;

    if (title.isEmpty || amount.isEmpty) return;

    widget._addTransactionHandler(Transaction(
        DateTime.now().microsecondsSinceEpoch.toString(),
        title,
        double.parse(amount),
        DateTime.now()));

    Navigator.of(context).pop();
  }

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
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountControler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text('No Date Chosen!'),
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor)
                ],
              ),
            ),
            FlatButton(
                child: Text('Add transaction',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: submitData)
          ],
        ),
      ),
    );
  }
}
