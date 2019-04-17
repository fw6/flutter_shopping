import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_shopping/model/cartInfo.dart';
import 'package:flutter_shopping/pages/cart_page/cart_count.dart';
import 'package:flutter_shopping/provide/cart.dart';
import 'package:provide/provide.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel _cartInfoItem;
  CartItem(this._cartInfoItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _cartCheckButton,
          _cartImage,
          _cartGoodsName,
          _cartPrice(context),
        ],
      ),
    );
  }

  // 选中按钮
  Widget get _cartCheckButton {
    return Container(
      child: Checkbox(
        value: _cartInfoItem.isChecked,
        activeColor: Colors.pink,
        onChanged: (bool val) {},
      ),
    );
  }

  // 商品图片
  Widget get _cartImage {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(_cartInfoItem.images),
    );
  }

  // 商品价格
  Widget get _cartGoodsName {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[Text(_cartInfoItem.goodsName), CartCount()],
      ),
    );
  }

  // 商品价格
  Widget _cartPrice(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${_cartInfoItem.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<CartProvide>(context)
                    .delete(_cartInfoItem.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
