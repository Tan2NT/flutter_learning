import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

class TransactionInput extends StatefulWidget {
  void Function(Transaction) _addTransactionHandler;

  TransactionInput(this._addTransactionHandler);

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime? _selectedDate = null;

  void _submitData() {
    String title = _titleControler.text;
    String amount = _amountControler.text;

    if (title.isEmpty || amount.isEmpty || _selectedDate == null) return;

    double enteredAmount = double.parse(amount);
    if (enteredAmount < 0) return;

    widget._addTransactionHandler(Transaction(
        DateTime.now().microsecondsSinceEpoch.toString(),
        title,
        enteredAmount,
        _selectedDate!));

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      _selectedDate = pickedDate;
    });
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
              controller: _titleControler,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountControler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(_selectedDate == null
                      ? 'No Date Chosen!'
                      : DateFormat.yMd().format(_selectedDate!)),
                  FlatButton(
                      onPressed: _presentDatePicker,
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
                onPressed: _submitData)
          ],
        ),
      ),
    );
  }
}
