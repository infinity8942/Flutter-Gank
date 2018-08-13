import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank/ui/comm/MyDrawer.dart';
import 'package:flutter_gank/ui/home//Gank.dart';
import 'package:flutter_gank/ui/home/ShopList.dart';
import 'package:flutter_gank/ui/home/User.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with SingleTickerProviderStateMixin {
  TabController tabController;
  int _tabIndex = 0;
  var appBarTitles = ['首页', '商城', '我的'];
  final tabTextStyleNormal = new TextStyle(color: Colors.grey);
  final tabTextStyleSelected = new TextStyle(color: Colors.blue);

  var _body;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  void initData() {
    _body = new IndexedStack(
      children: <Widget>[new Home(), new ShopList(), new User()],
      index: _tabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      ///底部导航栏
      bottomNavigationBar: new CupertinoTabBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home), title: getTabTitle(0)),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.shopping_cart), title: getTabTitle(1)),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.settings), title: getTabTitle(2)),
        ],
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),

      ///侧边栏
      drawer: MyDrawer(),
      body: _body,
    );
  }

  Text getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }
}
