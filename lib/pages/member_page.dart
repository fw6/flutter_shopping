import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '会员中心',
        ),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader,
          _orderTitle,
          _orderType,
          _actionList,
        ],
      ),
    );
  }

  // 顶部区域
  Widget get _topHeader {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20.0),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network(
                  'https://avatar.gitee.com/uploads/45/1909445_fwxy.png!avatar100?1538656547'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'Misky Von',
              style: TextStyle(
                color: Colors.black54,
                fontSize: ScreenUtil().setSp(36),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 订单标题
  Widget get _orderTitle {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget get _orderType {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          // -----
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size: 30,
                ),
                Text('待付款')
              ],
            ),
          ),
          // -----
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30,
                ),
                Text('待发货')
              ],
            ),
          ),
          // -----
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                Text('待收货')
              ],
            ),
          ),
          // -----
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size: 30,
                ),
                Text('待评价')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _actionList {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _customTile('领取优惠券'),
          _customTile('已领取优惠券'),
          _customTile('地址管理'),
          _customTile('客户电话'),
          _customTile('关于我们'),
        ],
      ),
    );
  }

  // 通用listtile
  Widget _customTile(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.blur_off,
        ),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }
}
