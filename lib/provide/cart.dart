import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:flutter_shopping/model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartList = [];
  double totalPrice = 0; // 总价格
  int count = 0; // 商品总数量
  bool isAllChecked = true; // 全选状态

  // 获取购物车详情
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    cartList = [];

    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      // 初始化
      totalPrice = 0;
      count = 0;
      isAllChecked = true;

      tempList.forEach((item) {
        if (item['isChecked']) {
          totalPrice += item['count'] * item['price'];
          count += item['count'];
        } else {
          isAllChecked = false;
        }
        cartList.add(CartInfoModel.fromJson(item));
      });
    }

    notifyListeners();
  }

  // 添加到购物车
  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());

    List<Map> tempList = (temp as List).cast();

    bool isHave = false;

    int ival = 0;

    // 每次保存初始化数量和总价
    totalPrice = 0;
    count = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;

        isHave = true;
      }

      if (item['isChecked']) {
        totalPrice += cartList[ival].price * cartList[ival].count;
        count += cartList[ival].count;
      }

      ival++;
    });

    // 新商品添加到购物车
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isChecked': true
      };

      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));

      totalPrice += price * count;
      count += count;
    }

    cartString = json.encode(tempList).toString();

    prefs.setString('cartInfo', cartString);

    notifyListeners();
  }

  // 清空购物车
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');

    cartList = [];

    notifyListeners();
  }

  // 删除单个商品
  delete(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int delIndex = 0;
    int tempIndex = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();
  }

  // 改变商品选中状态
  changeCheckedStatus(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    // 循环的索引
    int tempIndex = 0;
    // 要更换的索引
    int changeIndex = 0;

    tempList.map((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }

      tempIndex++;
    });

    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();
  }

  // 全选
  changeCheckAllStatus(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newTempList = [];

    for (var item in tempList) {
      var newItem = item;
      newItem['isCheckd'] = val;

      newTempList.add(newItem);
    }

    cartString = json.encode(newTempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();
  }

  // 商品数量加减
  addOrReduce(CartInfoModel cartItem, String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    if (status == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();
    cartString = tempList.toString();
  }
}
