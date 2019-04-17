import 'package:flutter/material.dart';
import 'package:flutter_shopping/pages/cart_page/cart_bottom.dart';
import 'package:provide/provide.dart';
import 'dart:async';

import 'package:flutter_shopping/model/cartInfo.dart';
import 'package:flutter_shopping/provide/cart.dart';
import 'package:flutter_shopping/pages/cart_page/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        body: FractionallySizedBox(
          widthFactor: 1.0,
          child: FutureBuilder(
            future: _getCartInfo(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CartInfoModel> cartInfo =
                    Provide.value<CartProvide>(context).cartList;

                return Stack(
                  children: <Widget>[
                    Provide<CartProvide>(
                      builder: (context, child, val) {
                        return ListView.builder(
                          itemCount: cartInfo.length,
                          itemBuilder: (context, index) {
                            return CartItem(cartInfo[index]);
                          },
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: CartBottom(),
                    )
                  ],
                );
              } else {
                return Container(
                  child: Text('no data'),
                );
              }
            },
          ),
        ));
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();

    return '完成';
  }
}
