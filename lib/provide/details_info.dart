import 'package:flutter/material.dart';

import 'package:flutter_shopping/model/details.dart';
import 'package:flutter_shopping/service/service_methods.dart';

import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo;

  bool isLeft = true;
  bool isRight = false;

  // 从后台获取商品信息
  getGoodsInfo(String id) async {
    var formData = {'goodId': id};
    await request('getGoodDetailById', formData: formData).then((val) {
      var responseData = json.decode(val.toString());

      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }

  // 改变tabbar
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }

    notifyListeners();
  }
}
