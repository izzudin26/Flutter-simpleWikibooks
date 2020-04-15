import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wikibook/details.dart';
import 'package:wikibook/service/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class Articles {
  final String snippet;
  final String title;
  final int pageId;
  final List content;

  Articles({this.snippet, this.title, this.pageId, this.content});
  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
        title: json['title'], snippet: json['snippet'], pageId: json['pageid']);
  }
}

class _HomeState extends State<Home> {
  final _keyword = TextEditingController();

  Future<List<Articles>> fetchPost() async {
    String title = _keyword.text;
    if (title != "") {
      var url =
          'https://id.wikipedia.org/w/api.php?action=query&list=search&prop=info&inprop=url&utf8=&format=json&origin=*&srlimit=20&srsearch=${title}';
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var resJson = jsonDecode(response.body);
        if (resJson['query']['search'] != null) {
          // print(resJson['query']['search']);
          return (resJson['query']['search'] as List)
              .map((f) => Articles.fromJson(f))
              .toList();
        } else {
          Navigator.pop(context);
        }
      }
    }
  }

  void _showAlert() {
    showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Find and Fetch Data'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          ),
        ));
  }

  void _searching() {
    if (_keyword.text != "") {
      fetchPost();
    } else {
      showDialog(
          context: context,
          builder: (_HomeState) => AlertDialog(
                title: Icon(Icons.warning),
                content: Text('Mohon Mengisi kolom pencarian'),
              ));
    }
  }

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  height: MediaQuery.of(context).size.height * .2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.book, size: 40, color: Colors.white),
                      Text(
                        'WIKIBOOKS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * .8,
                )
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left: 30,
              right: 30,
              child: AppBar(
                elevation: 5.0,
                primary: false,
                leading: Icon(Icons.book, color: Colors.blue),
                backgroundColor: Colors.white,
                title: TextField(
                    controller: _keyword,
                    decoration: InputDecoration(
                      hintText: "Cari Sesuatu ?",
                      border: InputBorder.none,
                    )),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _searching();
                      setState(() {});
                    },
                    child: Icon(Icons.search),
                    textColor: Colors.blue,
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .230,
                    left: 20,
                    right: 20,
                    bottom: 25),
                child: Getdata())
          ],
        ));
  }

  Widget Getdata() {
    return FutureBuilder(
      future: fetchPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DisplayData(datas: snapshot.data);
        } else if (snapshot.hasError) {
          return Text('Failed Fetching data');
        }
        return _keyword.text == ""
            ? Text('')
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class DisplayData extends StatelessWidget {
  final List<Articles> datas;

  DisplayData({Key key, this.datas}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 30),
      itemCount: datas.length,
      itemBuilder: (context, idx) {
        return Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail(
                            title: datas[idx].title,
                            pageid: datas[idx].pageId.toString(),
                            description: datas[idx].snippet)));
              },
              child: Card(
                  child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('${datas[idx].title}'),
                  )
                ],
              )),
            ),
            RaisedButton(onPressed: () {
              Authservices auth = new Authservices();
              auth.logOut();
              Navigator.of(context).pushReplacementNamed('/auth');
            })
          ],
        );
      },
    );
  }
}
