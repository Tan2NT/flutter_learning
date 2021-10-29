import 'package:flutter/material.dart';

import './transaction.dart';
import './transaction_input.dart';
import './transaction_list.dart';

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
  ];

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void addTransaction(Transaction transaction) {
    setState(() {
      transactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Money Management"),
      ),
      body: Column(
        // child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text(
                "CHART",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          TransactionInput(addTransaction),
          TransactionList(transactions),
        ],
        // ),
      ),
    );
  }
}
