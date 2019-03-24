import 'package:flutter/material.dart';
import 'package:flutter_shopping/service/service_methods.dart';
import 'package:flutter_shopping/model/category.dart';
import 'package:flutter_shopping/model/category_goods_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shopping/provide/category_child.dart';
import 'package:flutter_shopping/provide/category_goods_list.dart';

import 'dart:convert';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RightCategoryNav(),
                  CategoryGoodsList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<CategoryModelData> categoryData = [];
  var currentCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategory();
    _getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: ListView.builder(
        itemCount: categoryData.length,
        itemBuilder: (context, index) => _leftInkWell(index),
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;

    isClick = !!(index == currentCategoryIndex) && true;

    return InkWell(
      onTap: () {
        setState(() {
          currentCategoryIndex = index;
        });

        var childList = categoryData[index].bxMallSubDto;
        var categoryId = categoryData[index].mallCategoryId;

        Provide.value<CategoryChildProvide>(context)
            .getCategoryChild(childList);

        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(top: 20, left: 10),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Text(
          categoryData[index].mallCategoryName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel list = CategoryModel.fromJson(data);

      setState(() {
        categoryData = list.data;
      });

      Provide.value<CategoryChildProvide>(context)
          .getCategoryChild(categoryData[0].bxMallSubDto);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      "categoryId": categoryId == null ? 4 : categoryId,
      "CategorySubId": "",
      "page": 1
    };

    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsModel _goodsList = CategoryGoodsModel.fromJson(data);

      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(_goodsList.data);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide(
      builder: (context, child, categoryChild) => Container(
            width: ScreenUtil().setWidth(570),
            height: ScreenUtil().setHeight(80),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryChild.categoryChildList.length,
              itemBuilder: (context, index) {
                return _rightInkWell(categoryChild.categoryChildList[index]);
              },
            ),
          ),
    );
  }

  Widget _rightInkWell(CategoryModelDataBxMallSubDto item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }
}

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) => Container(
            width: ScreenUtil().setWidth(570),
            height: ScreenUtil().setHeight(1000),
            child: ListView.builder(
              itemCount: data.goodsList.length,
              itemBuilder: (context, index) => _listItem(data.goodsList[index]),
            ),
          ),
    );
  }

  Widget _listItem(CategoryGoodsData goodsItem) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(goodsItem),
            Column(
              children: <Widget>[
                _goodsName(goodsItem),
                _goodsPrice(goodsItem),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _goodsImage(CategoryGoodsData goodsItem) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(goodsItem.image),
    );
  }

  Widget _goodsName(CategoryGoodsData goodsItem) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(570),
      child: Text(
        goodsItem.goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(CategoryGoodsData goodsItem) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${goodsItem.presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
          Text(
            '价格：￥${goodsItem.oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              fontSize: ScreenUtil().setSp(24),
              decoration: TextDecoration.lineThrough,
            ),
          )
        ],
      ),
    );
  }
}
