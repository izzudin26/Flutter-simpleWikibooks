import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wikibook/details.dart';

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
          print(resJson['query']['search']);
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
      appBar: AppBar(
        centerTitle: false,
        leading: Icon(Icons.book),
        title: Text('Wikibook'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _keyword,
              decoration: InputDecoration(
                  labelText: "Cari Sesuatu ?",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: FlatButton(
                    onPressed: () {
                      _searching();
                      setState(() {});
                    },
                    child: Icon(Icons.search),
                    textColor: Colors.blue,
                  )),
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder(
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
              ),
            )
          ],
        ),
      ),
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
            )
          ],
        );
      },
    );
  }
}
