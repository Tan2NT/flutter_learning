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
    // Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Buy a ball",
    //     23.45, DateTime.now()),
    // Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Living fee",
    //     69.99, DateTime.now()),
    // Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Chicken dry",
    //     200.00, DateTime.now()),
    // Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 1",
    //     24.00, DateTime.now()),
    // Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 2",
    //     46.00, DateTime.now()),
    // Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 3",
    //     67.00, DateTime.now()),
    // Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 4",
    //     89.00, DateTime.now()),
    // Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 5",
    //     56.00, DateTime.now()),
    // Transaction(DateTime.now().millisecondsSinceEpoch.toString(), "Test 6",
    //     71.00, DateTime.now()),
  ];

  bool _showChart = false;

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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
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
    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(transactions, deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Show Chart"),
                      Switch(
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          })
                    ],
                  ),
                  _showChart
                      ? Container(
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              1,
                          child: Chart(_recentTransactions))
                      : txListWidget
                ],
              ),
            if (!isLandscape)
              Column(
                children: [
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.3,
                      child: Chart(_recentTransactions)),
                  txListWidget
                ],
              )
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
