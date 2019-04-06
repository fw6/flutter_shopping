import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: ScreenUtil().setWidth(740),
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      child: Text(
        '说明：正品保证 > 极速送达',
        style: TextStyle(
          color: Colors.red[600],
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }
}
