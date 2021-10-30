import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:money_app/transaction.dart';
import 'package:intl/intl.dart';
import 'package:money_app/transaction_input.dart';
import 'package:money_app/transaction_list.dart';
import 'package:money_app/user_transaction.dart';

import './transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Management',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'RobotoMono',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))),
      home: UserTransaction(),
    );
  }
}
