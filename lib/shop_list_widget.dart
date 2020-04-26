import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/product.dart';
import 'package:flutterapp/shopItem.dart';
import 'package:flutterapp/web_view_page.dart';

class ShopListWidget extends StatefulWidget {
  List<Product> _products;

  ShopListWidget(this._products);

  @override
  State<StatefulWidget> createState() {
    return ShopListState();
  }
}

class ShopListState extends State<ShopListWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget._products.map((Product p) {
        return ShopItem(p, onItemPress);
      }).toList(),
    );
  }

  void onItemPress(Product product) {
    setState(() {
      product.like = !product.like;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => WebViewPage(product.url)));
  }
}
