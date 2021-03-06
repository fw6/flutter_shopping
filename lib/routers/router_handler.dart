import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_shopping/pages/details_page.dart';
import 'package:flutter_shopping/pages/cart_page.dart';

Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String goodsId = params['id'].first;
    print('index > details goods is $goodsId');

    return DetailsPage(goodsId);
  },
);

Handler cartHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return CartPage();
  },
);
