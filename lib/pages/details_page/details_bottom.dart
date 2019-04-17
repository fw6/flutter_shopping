import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_shopping/provide/cart.dart';
import 'package:flutter_shopping/provide/details_info.dart';
import 'package:flutter_shopping/routers/application.dart';
import 'package:flutter_shopping/model/details.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailsModel detailsInfo =
        Provide.value<DetailsInfoProvide>(context).goodsInfo;

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(80),
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          InkWell(
            onTap: () {
              Application.router.navigateTo(context, '/cart');
            },
            child: Container(
              width: ScreenUtil().setWidth(110),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.red,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).save(
                  detailsInfo.data.goodInfo.goodsId,
                  detailsInfo.data.goodInfo.goodsName,
                  1,
                  detailsInfo.data.goodInfo.presentPrice,
                  detailsInfo.data.goodInfo.image1);
            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // TODO: 进入订单详情页
            },
            child: Container(
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.deepOrange,
              child: Text(
                '立即购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
