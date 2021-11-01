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
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text('\$${_userTransactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      _userTransactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(_userTransactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 500
                        ? FlatButton.icon(
                            onPressed: () {
                              _deleteHandler(_userTransactions[index].id);
                            },
                            textColor: Theme.of(context).errorColor,
                            icon: Icon(Icons.delete),
                            label: Text('delete'))
                        : IconButton(
                            onPressed: () {
                              _deleteHandler(_userTransactions[index].id);
                            },
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor)),
              );
              //TransactionItem(_userTransactions[index])
            },
            itemCount: _userTransactions.length,
          );
  }
}
