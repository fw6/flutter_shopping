import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_shopping/model/category.dart';
import 'package:flutter_shopping/model/category_goods_list.dart';
import 'package:flutter_shopping/provide/category_child.dart';
import 'package:flutter_shopping/provide/category_goods_list.dart';
import 'package:flutter_shopping/service/service_methods.dart';

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
                  Expanded(
                    child: CategoryGoodsList(),
                  )
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
            .getCategoryChild(childList, categoryId);

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

  void _getCategory() {
    request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel list = CategoryModel.fromJson(data);

      setState(() {
        categoryData = list.data;
      });

      Provide.value<CategoryChildProvide>(context).getCategoryChild(
          categoryData[0].bxMallSubDto, categoryData[0].mallCategoryId);
    });
  }

  void _getGoodsList({String categoryId}) {
    var data = {
      "categoryId": categoryId == null ? 4 : categoryId,
      "categorySubId": "",
      "page": 1
    };

    request('getMallGoods', formData: data).then((val) {
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
    return Provide<CategoryChildProvide>(
      builder: (context, child, categoryChild) => Container(
            height: ScreenUtil().setHeight(80),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryChild.categoryChildList.length,
              itemBuilder: (context, index) {
                return _rightInkWell(
                    index, categoryChild.categoryChildList[index]);
              },
            ),
          ),
    );
  }

  Widget _rightInkWell(int index, CategoryModelDataBxMallSubDto item) {
    bool isClicked = false;
    isClicked =
        !!(index == Provide.value<CategoryChildProvide>(context).childIndex) &&
            true;

    return InkWell(
      onTap: () {
        Provide.value<CategoryChildProvide>(context)
            .changeChildIndex(index, item.mallSubId);
        if (index == 0) {
          _getGoodsList('');
        } else {
          _getGoodsList(item.mallSubId);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClicked ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  void _getGoodsList(String categorySubId) {
    var data = {
      "categoryId": Provide.value<CategoryChildProvide>(context).categoryId,
      "categorySubId": categorySubId,
      "page": 1
    };

    request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsModel _goodsList = CategoryGoodsModel.fromJson(data);

      if (_goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getGoodsList(_goodsList.data);
      }
    });
  }
}

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if (Provide.value<CategoryChildProvide>(context).page == 1) {
            // 切换后列表返回顶部
            _scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化：$e');
        }

        if (data.goodsList.length > 0) {
          return Container(
            child: EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText:
                    Provide.value<CategoryChildProvide>(context).noMoreText,
                moreInfo: '加载中',
                loadReadyText: '上拉加载...',
              ),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: data.goodsList.length,
                itemBuilder: (context, index) =>
                    _listItem(data.goodsList[index]),
              ),
              loadMore: () async {
                _getMoreGoodsList();
              },
            ),
          );
        }

        return Text('暂时没有数据');
      },
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
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _goodsImage(goodsItem),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: <Widget>[
                    _goodsName(goodsItem),
                    _goodsPrice(goodsItem),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _goodsImage(CategoryGoodsData goodsItem) {
    return Container(
      width: ScreenUtil().setWidth(180),
      height: ScreenUtil().setHeight(190),
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Image.network(goodsItem.image),
    );
  }

  Widget _goodsName(CategoryGoodsData goodsItem) {
    return Container(
      width: ScreenUtil().setWidth(450),
      padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
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
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${goodsItem.presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
          Text(
            '价格：￥${goodsItem.oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              fontSize: ScreenUtil().setSp(22),
              decoration: TextDecoration.lineThrough,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  void _getMoreGoodsList() {
    Provide.value<CategoryChildProvide>(context).addPage();

    var data = {
      "categoryId": Provide.value<CategoryChildProvide>(context).categoryId,
      "categorySubId": Provide.value<CategoryChildProvide>(context).subId,
      "page": Provide.value<CategoryChildProvide>(context).page,
    };

    request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsModel _goodsList = CategoryGoodsModel.fromJson(data);

      if (_goodsList.data == null) {
        Fluttertoast.showToast(
          msg: '已经到底了',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(16),
        );

        Provide.value<CategoryChildProvide>(context).changeNoMore('没有更多了');
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getMoreGoodsList(_goodsList.data);
      }
    });
  }
}
