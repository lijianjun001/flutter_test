import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MyWeb extends StatefulWidget {
  String title;
  String url;

  MyWeb(this.url, this.title);

  MyWebState createState() {
    return MyWebState();
  }
}

class MyWebState extends State<MyWeb> {
  var webPlugin = FlutterWebviewPlugin();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    webPlugin.onUrlChanged.listen((String url) {
      webPlugin.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: WebviewScaffold(
        url: widget.url,
        withZoom: false,
        withLocalStorage: true,
        withJavascript: true,
        hidden: true,
      ),
    );
  }
}
