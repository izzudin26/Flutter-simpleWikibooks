import 'package:flutter/material.dart';
import 'package:wikibook/home.dart';
import 'package:wikibook/login.dart';
import 'package:wikibook/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wikibook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Home(),
        '/auth': (BuildContext context) => Login()
      },
    );
  }
}
