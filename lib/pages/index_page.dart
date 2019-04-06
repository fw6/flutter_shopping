import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_shopping/pages/cart_page.dart';
import 'package:flutter_shopping/pages/category_page.dart';
import 'package:flutter_shopping/pages/member_page.dart';
import 'package:flutter_shopping/pages/home_page.dart';

class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('个人中心'),
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  int _currentIndex = 0;
  // var _currentPage;

  void initState() {
    super.initState();
    // _currentPage = tabBodies[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // _currentPage = tabBodies[_currentIndex];
          });
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: tabBodies,
      ),
    );
  }
}
