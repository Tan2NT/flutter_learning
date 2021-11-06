import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required Transaction transaction,
    required Function(String p1) deleteHandler,
  })  : transaction = transaction,
        _deleteHandler = deleteHandler,
        super(key: key);

  final Transaction transaction;
  final Function(String p1) _deleteHandler;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: FittedBox(
                child: Text('\$${transaction.amount}'),
              ),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
          trailing: MediaQuery.of(context).size.width > 500
              ? FlatButton.icon(
                  onPressed: () {
                    _deleteHandler(transaction.id);
                  },
                  textColor: Theme.of(context).errorColor,
                  icon: Icon(Icons.delete),
                  label: const Text('delete'))
              : IconButton(
                  onPressed: () {
                    _deleteHandler(transaction.id);
                  },
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor)),
    );
  }
}
