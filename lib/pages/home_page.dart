import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();
  String showText = '欢迎来到美好人间';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('找小姐姐'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: '美女类型',
                      labelStyle:
                          TextStyle(fontSize: 14.0, color: Colors.purple)),
                  autofocus: false,
                ),
                RaisedButton(
                  onPressed: _choiceAction,
                  child: Text('提交'),
                ),
                Text(
                  showText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _choiceAction() {
    print('');
    String inputValue = _textEditingController.text.toString();
    if (inputValue == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('美女内容不为空'),
              ));
    } else {
      getHttp(inputValue).then((value) {
        setState(() {
          showText = value.data.name;
        });
      });
    }
  }

  Future getHttp(String typeText) async {
    try {
      Response response;
      var data = {'name': typeText};
      response = await Dio().get(
          'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
          queryParameters: data);

      return response.data;
    } catch (err) {}
  }
}
