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

  getCategoryChild(List<CategoryModelDataBxMallSubDto> list, String id) {
    childIndex = 0;
    categoryId = id;
    CategoryModelDataBxMallSubDto all = CategoryModelDataBxMallSubDto();
    all.mallSubId = 'all_data';
    all.mallSubName = '全部';
    all.mallCategoryId = 'all_data_category_id';
    all.comments = 'null';
    categoryChildList = [all];

    categoryChildList.addAll(list);

    notifyListeners();
  }

  changeChildIndex(index, id) {
    childIndex = index;
    subId = id;
    notifyListeners();
  }
}
