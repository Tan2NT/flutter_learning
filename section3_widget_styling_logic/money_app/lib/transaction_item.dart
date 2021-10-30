import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColorLight, width: 2)),
            padding: EdgeInsets.all(10),
            child: Card(
                child: Text(
              '\$ ${transaction.amount}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).primaryColorDark),
            )),
            width: 100,
          ),
          Card(
            child: Column(
              children: [
                Card(
                    child: Text(
                  transaction.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
                Card(
                    child: Text(DateFormat.MMMEd().format(transaction.date),
                        style: TextStyle(color: Colors.blueGrey, fontSize: 12),
                        textAlign: TextAlign.left)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
