import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/product.dart';

class ShopItem extends StatelessWidget {
  final Product _product;
  final CartChangedCallback _onPress;

  ShopItem(this._product, this._onPress);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      onTap: () {
        _onPress(_product);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Image.network(_product.avatar),
      ),
      title: Text(_product.name),
      trailing: Icon(Icons.arrow_right),
    );
  }

  Color _getColor(BuildContext context) {
    return _product.like ? Colors.black54 : Theme.of(context).primaryColor;
  }
}

typedef void CartChangedCallback(Product product);
