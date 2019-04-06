import 'package:flutter/material.dart';
import 'package:flutter_shopping/pages/index_page.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_shopping/provide/counter.dart';
import 'package:flutter_shopping/provide/category_child.dart';
import 'package:flutter_shopping/provide/category_goods_list.dart';
import 'package:flutter_shopping/provide/details_info.dart';
import 'package:flutter_shopping/routers/application.dart';
import 'package:flutter_shopping/routers/routes.dart';

void main() {
  Providers providers = Providers();
  Counter counter = Counter();
  CategoryChildProvide categoryChild = CategoryChildProvide();
  CategoryGoodsListProvide categoryGoodsList = CategoryGoodsListProvide();
  DetailsInfoProvide detailsInfo = DetailsInfoProvide();

  // 状态放入顶层
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<CategoryChildProvide>.value(categoryChild))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfo));

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
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活 +',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}
