import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/transaction.dart';
import 'package:money_app/transaction_item.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> _userTransactions;
  Function(String) _deleteHandler;

  TransactionList(this._userTransactions, this._deleteHandler);

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
                      trailing: IconButton(
                          onPressed: () {
                            _deleteHandler(_userTransactions[index].id);
                          },
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor)),
                );
                //TransactionItem(_userTransactions[index])
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
