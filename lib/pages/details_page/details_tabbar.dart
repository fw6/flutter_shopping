import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_shopping/provide/details_info.dart';

class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        bool isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        bool isRight = Provide.value<DetailsInfoProvide>(context).isRight;

        return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Row(
            children: <Widget>[
              _myTabbarLeft(context, isLeft),
              _myTabbarRight(context, isRight),
            ],
          ),
        );
      },
    );
  }

  // 详情页
  Widget _myTabbarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isLeft ? Colors.pink : Colors.black12,
            ),
          ),
        ),
        child: Text(
          '详情',
          style: TextStyle(
            color: isLeft ? Colors.pink : Colors.black12,
          ),
        ),
      ),
    );
  }

  // 评论页
  Widget _myTabbarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isRight ? Colors.pink : Colors.black12,
            ),
          ),
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color: isRight ? Colors.pink : Colors.black12,
          ),
        ),
      ),
    );
  }
}
