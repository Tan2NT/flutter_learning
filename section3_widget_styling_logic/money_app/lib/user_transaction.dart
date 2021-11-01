import 'package:flutter/material.dart';

import './transaction.dart';
import './transaction_input.dart';
import './transaction_list.dart';
import './chart.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> transactions = [
    Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Buy a ball",
        23.45, DateTime.now()),
    Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Living fee",
        69.99, DateTime.now()),
    Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Chicken dry",
        200.00, DateTime.now()),
    Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 1",
        24.00, DateTime.now()),
    Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 2",
        46.00, DateTime.now()),
    Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 3",
        67.00, DateTime.now()),
    Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 4",
        89.00, DateTime.now()),
    Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 5",
        56.00, DateTime.now()),
    Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 6",
        71.00, DateTime.now()),
  ];

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
            onTap: () {},
            child: TransactionInput(addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void addTransaction(Transaction transaction) {
    setState(() {
      transactions.add(transaction);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return transactions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Money Management"),
      backgroundColor: Colors.blueAccent,
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startAddTransaction(context);
            })
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.4,
                child: Chart(_recentTransactions)),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.6,
                child: TransactionList(transactions, deleteTransaction))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddTransaction(context);
        },
      ),
    );
  }
}
