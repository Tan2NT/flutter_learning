import 'package:flutter/material.dart';
import 'package:money_app/chart_bar.dart';
import 'package:money_app/transaction.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + double.parse(item['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: ChartBar(
                        data['day'].toString(),
                        double.parse(data['amount'].toString()),
                        (totalSpending != null)
                            ? double.parse(data['amount'].toString()) /
                                totalSpending
                            : 0.0));
              }).toList()),
        ));
  }
}
