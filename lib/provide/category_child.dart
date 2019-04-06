import 'package:flutter/material.dart';

import 'package:flutter_shopping/model/category.dart';

class CategoryChildProvide with ChangeNotifier {
  List<CategoryModelDataBxMallSubDto> categoryChildList = [];
  // 子类导航索引
  int childIndex = 0;
  // 大类ID
  String categoryId = '4';
  // 小类ID
  String subId = '';
  // 列表页页数
  int page = 1;
  // 无数据文本
  String noMoreText = '';

  // 切换大类
  getCategoryChild(List<CategoryModelDataBxMallSubDto> list, String id) {
    page = 1;
    noMoreText = '';
    childIndex = 0;
    categoryId = id;
    CategoryModelDataBxMallSubDto all = CategoryModelDataBxMallSubDto();
    all.mallSubName = '全部';
    all.mallSubId = '';
    all.mallCategoryId = '';
    all.comments = 'null';
    categoryChildList = [all];

    categoryChildList.addAll(list);

    notifyListeners();
  }

  // 切换小类
  changeChildIndex(int index, String id) {
    page = 1;
    noMoreText = '';

    childIndex = index;
    subId = id;
    notifyListeners();
  }

  // 下拉加载
  addPage() {
    page++;
  }

  // 改变 无数据文本
  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
