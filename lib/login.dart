import 'package:flutter/material.dart';
import 'package:wikibook/service/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final auth = new Authservices();

  void login() {
    auth.signIn(email.text, password.text);
  }

  void getUser() {
    auth.getUser().then((user) {
      if (user != null) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        print(user.toString());
      }
    }).catchError((onError) => print(onError.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'image/firebase_logo.png',
              scale: 3,
            )
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: TextField(
            controller: email,
            decoration: InputDecoration(
                labelText: "EMAIL",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: TextField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(
                labelText: "PASSWORD",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: RaisedButton(
            onPressed: () {
              login();
              getUser();
            },
            color: Colors.blue,
            child: Text("LOGIN"),
            textColor: Colors.white,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: RaisedButton(
            onPressed: () {
              auth.registerUser(email.text, password.text);
            },
            color: Colors.green,
            child: Text("REGISTRATION"),
            textColor: Colors.white,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("OR LOGIN USING"),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            auth.googleSignIn();
            getUser();
          },
          child: Image.asset(
            'image/google.png',
            width: 50,
          ),
        )
      ],
    )));
  }
}
