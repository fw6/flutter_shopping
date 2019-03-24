import 'package:flutter/material.dart';
import 'package:flutter_shopping/pages/index_page.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shopping/provide/counter.dart';
import 'package:flutter_shopping/provide/category_child.dart';
import 'package:flutter_shopping/provide/category_goods_list.dart';

void main() {
  var providers = Providers();
  var counter = Counter();
  var categoryChild = CategoryChildProvide();
  var categoryGoodsList = CategoryGoodsListProvide();
  // 状态放入顶层
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<CategoryChildProvide>.value(categoryChild))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList));

  runApp(
    ProviderNode(
      child: MyApp(),
      providers: providers,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活 +',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}
