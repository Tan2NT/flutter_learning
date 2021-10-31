import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Container(
                    height: 100,
                    child: Text('Item 1 - prettry big big'),
                    color: Colors.green)),
            Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Container(
                    height: 100, child: Text('Item 2'), color: Colors.blue)),
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                    height: 100, child: Text('Item 3'), color: Colors.orange)),
          ],
        ));
  }
}
