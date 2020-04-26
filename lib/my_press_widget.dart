import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPressWidget extends StatefulWidget {
  String title;
  VoidCallback onPressed;

  MyPressWidget(this.title);

  _MyPressState createState() {
    return _MyPressState();
  }
}

class _MyPressState extends State<MyPressWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: widget.onPressed,
      child: IconButton(
        iconSize: 100,
        onPressed: _press,
        icon: Icon(Icons.ac_unit),
        tooltip: _count.toString(),
      ),
    );
  }

  int _count;

  void _press() {
    setState(() {
      _count++;
    });
  }
}
