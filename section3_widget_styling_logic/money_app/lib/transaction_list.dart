import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:money_app/transaction.dart';
import 'package:money_app/transaction_item.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> _userTransactions;
  Function(String) _deleteHandler;

  TransactionList(this._userTransactions, this._deleteHandler);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: constraints.maxHeight * 0.2,
                    child: Text(
                      "No transaction yet!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.5,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover),
                  )
                ]);
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(
                  transaction: _userTransactions[index],
                  deleteHandler: _deleteHandler);
            },
            itemCount: _userTransactions.length,
          );
  }
}
