import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shopping/provide/counter.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            children: <Widget>[Number(), MyButton()],
          ),
        ),
      ),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Provide<Counter>(
        builder: (context, child, counter) => Text('${counter.value}'),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
        child: Text('MyButton'),
      ),
    );
  }
}
