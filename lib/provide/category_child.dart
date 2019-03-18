import 'package:flutter/material.dart';
import 'package:flutter_shopping/model/category.dart';

class CategoryChild with ChangeNotifier {
  List<CategoryModelDataBxMallSubDto> categoryChildList = [];

  getCategoryChild(List<CategoryModelDataBxMallSubDto> list) {
    CategoryModelDataBxMallSubDto all = CategoryModelDataBxMallSubDto();
    all.mallSubId = 'all_data';
    all.mallSubName = '全部';
    all.mallCategoryId = 'all_data_category_id';
    all.comments = 'null';
    categoryChildList = [all];

    categoryChildList.addAll(list);

    notifyListeners();
  }
}
