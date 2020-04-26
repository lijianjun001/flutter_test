/// @Author: 一凨
/// @Date: 2019-01-14 17:44:47
/// @Last Modified by: 一凨
/// @Last Modified time: 2019-01-14 19:47:14

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  var title = "测试";

  WebViewPage(this.url);

  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //获取h5页面标题
  Future<void> getWebTitle() async {
    String script = 'window.document.title';
    var title = await flutterWebviewPlugin.evalJavascript(script);
    setState(() {
      widget.title = title;
      print('####################   $title');
    });
  }

  bool _isExit = false;

  int _lastTime = 0;

  Future<bool> _onWillPop() {
    if (_isExit) {
      if (DateTime.now().millisecond - _lastTime < 2 * 1000) {
        return Future.value(true);
      }
      return Future.value(false);
    } else {
      Fluttertoast.showToast(
        msg: "are you sure exit app",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      _lastTime = DateTime.now().millisecond;
      _isExit = true;
      Future.delayed(Duration(seconds: 2)).then((_) {
        _isExit = false;
      });
      return Future.value(false);
    }
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print('url change:$url');
    }, onDone: () {}, cancelOnError: true);

    flutterWebviewPlugin.onStateChanged
        .listen((WebViewStateChanged changed) async {
      switch (changed.type) {
        case WebViewState.finishLoad:
          getWebTitle();
          break;
        case WebViewState.shouldStart:
          // TODO: Handle this case.
          break;
        case WebViewState.startLoad:
          // TODO: Handle this case.
          break;
        case WebViewState.abortLoad:
          // TODO: Handle this case.
          break;
      }
    });

    flutterWebviewPlugin.onProgressChanged.listen((double progress) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(),
            textAlign: TextAlign.right,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: onBack,
          ),
        ),
        body: WillPopScope(
          child: WebviewScaffold(
            url: widget.url,
            withZoom: false,
            withLocalStorage: true,
            withJavascript: true,
          ),
          onWillPop: _onWillPop,
        ));
  }

  void _error() {}

  void onBack() {
    flutterWebviewPlugin.canGoBack().then((bool can) {
      if (can) {
        flutterWebviewPlugin.goBack();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterWebviewPlugin.dispose();
  }
}
