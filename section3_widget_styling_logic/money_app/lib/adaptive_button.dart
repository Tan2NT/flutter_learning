import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String title;
  final Function _eventHandler;

  AdaptiveFlatButton(this.title, this._eventHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => _eventHandler())
        : FlatButton(
            onPressed: () => _eventHandler(),
            child: Text(
              'Choose Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            textColor: Theme.of(context).primaryColor);
  }
}
