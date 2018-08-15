import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gank/models/GankItem.dart';
import 'package:flutter_gank/models/GankList.dart';
import 'package:flutter_gank/ui/comm/LoadingMoreFooter.dart';
import 'package:flutter_gank/ui/comm/LoadingPage.dart';
import 'package:flutter_gank/ui/comm/MyWebview.dart';

class AndroidPage extends StatefulWidget {
  @override
  _AndroidPageState createState() => _AndroidPageState();
}

class _AndroidPageState extends State<AndroidPage> {
  static const platform = const MethodChannel('com.example.fluttergank/plugin');

  final List<GankItem> data = <GankItem>[];
  num currPage = 1;
  ScrollController _controller;

  CancelToken token = new CancelToken();

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        var maxScroll = _controller.position.maxScrollExtent;
        var pixels = _controller.position.pixels;
        if (maxScroll - pixels < 200.0) {
          currPage++;
          _getData(false);
        }
      });
    _getData(true);
  }

  Future<Null> _getData(bool isRefresh) async {
    if (isRefresh) {
      data.clear();
      currPage = 1;

      _test();
    }
    await Dio()
        .get('http://gank.io/api/data/Android/10/$currPage', cancelToken: token)
        .catchError((DioError err) {
      if (CancelToken.isCancel(err)) {
        print('Request canceled! ' + err.message);
      } else {
        // handle error.
      }
    }).then((resp) {
      GankList gankList = GankList.fromJson(resp.data);
      setState(() {
        data.addAll(gankList.results);
      });
    }, onError: () {});
  }

  @override
  Widget build(BuildContext context) {
    Widget listview = RefreshIndicator(
      child: ListView.builder(
        itemCount: 2 * data.length + 1,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider(height: 1.0);
          if (i == 2 * data.length) return LoadingMoreFooter();
          final index = i ~/ 2;
          return _buildRow(data[index]);
        },
        controller: _controller,
      ),
      onRefresh: () => _getData(true),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Android'),
      ),
      body: data.length == 0 ? LoadingPage() : listview,
    );
  }

  Widget _buildRow(GankItem item) {
    return ListTile(
      title: Text(item.desc),
      subtitle: Text(item.who),
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return MyWebview(title: item.desc, url: item.url);
          })),
    );
  }

  ///测试平台插件
  Future<Null> _test() async {
    String returnData;
    try {
      returnData = '平台返回数据：' + await platform.invokeMethod('YourMethodName');
    } on PlatformException catch (e) {
      returnData = '错误信息：${e.message}';
    }

    print('Request canceled! ' + returnData);
  }

  @override
  void dispose() {
    token.cancel("cancelled");
    super.dispose();
  }
}
