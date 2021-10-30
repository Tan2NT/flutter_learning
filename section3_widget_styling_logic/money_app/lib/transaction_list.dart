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
      child: _userTransactions.isEmpty
          ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                'No transactions added yet!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child:
                    Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
              )
            ])
          : ListView.builder(
              itemBuilder: (context, index) {
                return TransactionItem(_userTransactions[index]);
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
