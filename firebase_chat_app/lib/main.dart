import 'package:firebase_chat_app/screens/chat_screen.dart';
import 'package:firebase_chat_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        future: _initialization,
        builder: (ctx, appSapshot) {
          return MaterialApp(
              title: 'FlutterChat',
              theme: ThemeData(
                primarySwatch: Colors.pink,
                backgroundColor: Colors.pink,
                accentColor: Colors.deepPurple,
                accentColorBrightness: Brightness.dark,
                buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.pink,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              home: appSapshot.connectionState != ConnectionState.done
                  ? SplashScreen()
                  : ChatScreen());
        });
  }
}
