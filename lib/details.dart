import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final String title;
  final String description;

  Detail({Key key, this.title, this.description}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(widget.title,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
                widget.description
                    .replaceAll('<span class=\"searchmatch\">', '')
                    .replaceAll('</span>', '')
                    .replaceAll('&quot;', ''),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
          )
        ],
      ),
    );
  }
}
