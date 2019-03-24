import 'package:flutter/material.dart';
import 'package:flutter_shopping/model/category_goods_list.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryGoodsData> goodsList = [];

  getGoodsList(List<CategoryGoodsData> list) {
    goodsList = list;

    notifyListeners();
  }
}
