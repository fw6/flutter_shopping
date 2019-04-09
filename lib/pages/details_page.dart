import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:flutter_shopping/routers/application.dart';
// import 'package:flutter_shopping/model/details.dart';
// import 'package:flutter_shopping/service/service_methods.dart';
import 'package:flutter_shopping/provide/details_info.dart';
import 'package:flutter_shopping/pages/details_page/details_top.dart';
import 'package:flutter_shopping/pages/details_page/details_explain.dart';
import 'package:flutter_shopping/pages/details_page/details_tabbar.dart';
import 'package:flutter_shopping/pages/details_page/details_web.dart';
import 'package:flutter_shopping/pages/details_page/details_bottom.dart';

import 'dart:async';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabbar(),
                      DetailsWeb(),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottom(),
                )
              ],
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }

  Future<String> _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}
