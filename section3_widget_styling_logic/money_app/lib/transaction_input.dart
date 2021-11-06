import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/adaptive_button.dart';

import './transaction.dart';

class TransactionInput extends StatefulWidget {
  void Function(Transaction) _addTransactionHandler;

  TransactionInput(this._addTransactionHandler) {
    print('Constructor ---------- ');
  }

  @override
  State<TransactionInput> createState() {
    print('createState');
    return _TransactionInputState();
  }
}

class _TransactionInputState extends State<TransactionInput> {
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime? _selectedDate = null;

  _TransactionInputState() {
    print('new _TransactionInputState');
  }

  @override
  void initState() {
    print('initState');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TransactionInput oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

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
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
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
                    AdaptiveFlatButton("Choose Date", _presentDatePicker)
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
      ),
    );
  }
}
