import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_shopping/model/details.dart';
import 'package:flutter_shopping/provide/details_info.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        DetailsGoodInfo goodsInfo =
            Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;

        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
              ],
            ),
          );
        } else {
          return Text('加载中...');
        }
      },
    );
  }

  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }

  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号：$num',
        style: TextStyle(
          color: Colors.black12,
        ),
      ),
    );
  }

  Widget _goodsPrice(double presentPrice, double oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '￥$presentPrice',
              style: TextStyle(
                color: Colors.red[200],
              ),
            ),
            TextSpan(children: <TextSpan>[
              TextSpan(
                text: '市场价',
              ),
              TextSpan(
                text: '￥$oriPrice',
                style: TextStyle(
                  color: Colors.black12,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
