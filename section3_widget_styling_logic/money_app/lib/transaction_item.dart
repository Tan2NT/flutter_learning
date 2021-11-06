import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';

class TransactionItem extends StatefulWidget {
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
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor = Colors.green;

  @override
  void initState() {
    const availableColors = [
      Colors.purple,
      Colors.green,
      Colors.yellow,
      Colors.blue
    ];
    _bgColor = availableColors[Random().nextInt(availableColors.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: FittedBox(
                child: Text('\$${widget.transaction.amount}'),
              ),
            ),
          ),
          title: Text(
            widget.transaction.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
          trailing: MediaQuery.of(context).size.width > 500
              ? FlatButton.icon(
                  onPressed: () {
                    widget._deleteHandler(widget.transaction.id);
                  },
                  textColor: Theme.of(context).errorColor,
                  icon: Icon(Icons.delete),
                  label: const Text('delete'))
              : IconButton(
                  onPressed: () {
                    widget._deleteHandler(widget.transaction.id);
                  },
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor)),
    );
  }
}
