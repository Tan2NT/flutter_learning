import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  String name;
  final void Function(String) selectHandler;

  Item(this.name, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text(
          name,
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
            foregroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: () => selectHandler(name),
      ),
    );
  }
}
