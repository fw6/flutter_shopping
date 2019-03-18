import 'package:flutter/material.dart';
import 'package:flutter_shopping/service/service_methods.dart';
import 'package:flutter_shopping/model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shopping/provide/category_child.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: categoryData.length,
        itemBuilder: (context, index) => _leftInkWell(index),
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;

    isClick = (index == currentCategoryIndex) && true;

    return InkWell(
      onTap: () {
        setState(() {
          currentCategoryIndex = index;
        });

        var childList = categoryData[index].bxMallSubDto;
        Provide.value<CategoryChild>(context).getCategoryChild(childList);
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

      Provide.value<CategoryChild>(context)
          .getCategoryChild(categoryData[0].bxMallSubDto);
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
            width: ScreenUtil().setHeight(570),
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
