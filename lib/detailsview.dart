import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailsView extends StatefulWidget {
  @override
  final String pageid;
  DetailsView({Key key, this.pageid}) : super(key: key);
  DetailsViewState createState() => DetailsViewState();
}

class DetailsViewState extends State<DetailsView> {
  String urlEndpoint;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  void initState() {
    super.initState();
    setState(() {
      urlEndpoint = "https://id.m.wikipedia.org/?curid=${widget.pageid}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: urlEndpoint,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webviewcontroller) {
          _controller.complete(webviewcontroller);
        },
      ),
    );
  }
}
