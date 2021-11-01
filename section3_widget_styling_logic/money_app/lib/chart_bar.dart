import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            flex: 1,
            child: Container(
              child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(1)}.'),
              ),
            )),
        Flexible(
          flex: 1,
          child: SizedBox(),
        ),
        Flexible(
            flex: 4,
            fit: FlexFit.loose,
            child: Container(
              width: 10,
              child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10))),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor:
                        spendingPctOfTotal != null ? spendingPctOfTotal : 0.0,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.greenAccent),
                    ),
                  ),
                )
              ]),
            )),
        Flexible(
            flex: 1,
            child: FittedBox(
              child: Text('${label}'),
            )),
      ],
    );
  }
}
