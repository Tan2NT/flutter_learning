import 'package:flutter/material.dart';
import './Item.dart';

class Option extends StatelessWidget {
  final List<String> items;
  final void Function(String) selectHandler;

  Option(this.items, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...(items).map((itemName) {
          return Item(itemName, selectHandler);
        }).toList()
      ],
    );
  }
}
