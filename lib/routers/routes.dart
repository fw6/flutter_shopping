import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_shopping/routers/router_handler.dart';

class Routes {
  static String root = '/';
  static String detailsPage = '/detail';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Container(
        child: Center(
          child: Text('404'),
        ),
      );
    });

    router.define(detailsPage, handler: detailsHandler);
  }
}
