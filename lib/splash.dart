import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wikibook/service/auth.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void startTime() {
    final duration = Duration(seconds: 2);
    Timer(duration, navigation);
  }

  void navigation() {
    Authservices auth = new Authservices();
    auth.getUser().then((user) {
      if (user != null) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/auth');
      }
    }).catchError((onError) => print(onError.toString()));
  }

  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'image/wikibook.png',
              scale: 3,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
