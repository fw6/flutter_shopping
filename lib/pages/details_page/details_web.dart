import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_shopping/provide/details_info.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String goodsDetail = Provide.value<DetailsInfoProvide>(context)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail;

    return Container(
      child: Html(
        data: goodsDetail,
      ),
    );
  }
}
