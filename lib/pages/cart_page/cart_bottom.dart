import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shopping/provide/cart.dart';
import 'package:provide/provide.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Container(
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
        child: Provide<CartProvide>(
          builder: (context, child, val) {
            return Row(
              children: <Widget>[
                selectAllButton(context),
                totalPrice(context),
                settlement(context),
              ],
            );
          },
        ),
      ),
    );
  }

  // 选中全部
  Widget selectAllButton(context) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: Provide.value<CartProvide>(context).isAllChecked,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              Provide.value<CartProvide>(context).changeCheckAllStatus(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  // 总价
  Widget totalPrice(BuildContext context) {
    double totalPrice = Provide.value<CartProvide>(context).totalPrice;

    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '￥ $totalPrice',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36), color: Colors.red),
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                  color: Colors.black38, fontSize: ScreenUtil().setSp(22)),
            ),
          )
        ],
      ),
    );
  }

  // 结算(数量)
  Widget settlement(BuildContext context) {
    int count = Provide.value<CartProvide>(context).count;

    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '结算($count)',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
