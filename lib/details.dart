import 'package:flutter/material.dart';
import 'detailsview.dart';

class Detail extends StatefulWidget {
  final String title;
  final String description;
  final String pageid;
  Detail({Key key, this.title, this.description, this.pageid})
      : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  void navigationWeb(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsView(
      pageid: widget.pageid,
    )));
  }

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
            child: Text(
              widget.title,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
                widget.description
                    .replaceAll('<span class=\"searchmatch\">', '')
                    .replaceAll('</span>', '')
                    .replaceAll('&quot;', ''),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: () {
              navigationWeb();
            },
            color: Colors.blue,
            elevation: 3,
            child: Text(
              'Baca selengkapnya',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
