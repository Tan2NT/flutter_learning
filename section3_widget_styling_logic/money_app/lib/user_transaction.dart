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
    // Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 2",
    //     46.00, DateTime.now()),
    // Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 3",
    //     67.00, DateTime.now()),
    // Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 4",
    //     89.00, DateTime.now()),
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

  List<Transaction> get _recentTransactions {
    var myList = [0, 2, 4, 6, 8, 2, 7];
    myList.where((item) => item > 5).toList();
    return transactions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Money Management"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                startAddTransaction(context);
              })
        ],
      ),
      body: Column(
        children: [
          Chart(_recentTransactions),
          TransactionList(transactions),
        ],
        // ),
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
