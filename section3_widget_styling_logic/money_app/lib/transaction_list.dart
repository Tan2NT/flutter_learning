import 'package:flutter/material.dart';
import 'package:money_app/transaction.dart';
import 'package:money_app/transaction_item.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> _userTransactions;

  TransactionList(this._userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return TransactionItem(_userTransactions[index]);
        },
        itemCount: _userTransactions.length,
      ),
    );
  }
}
