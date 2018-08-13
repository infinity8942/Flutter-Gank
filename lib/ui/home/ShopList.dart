import 'package:flutter/material.dart';
import 'package:flutter_gank/ui/comm/MyTabBar.dart';
import 'package:flutter_gank/ui/home/Shop.dart';

class ShopList extends StatefulWidget {
  @override
  _ShopListWidgetState createState() => _ShopListWidgetState();
}

class _ShopListWidgetState extends State<ShopList> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final PageController topPageControl = new PageController();
  final List<String> tab = ["111", "222", "333"];

  _renderTab() {
    List<Widget> list = new List();
    for (int i = 0; i < tab.length; i++) {
      list.add(new FlatButton(
          onPressed: () {
            topPageControl.jumpTo(MediaQuery.of(context).size.width * i);
          },
          child: new Text(
            tab[i],
            style: TextStyle(color: Colors.white),
            maxLines: 1,
          )));
    }
    return list;
  }

  _renderPage() {
    return [
      new Shop(),
      new Shop(),
      new Shop(),
    ];
  }

  void showSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {},
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new MyTabBar(
      scaffoldKey: scaffoldKey,
      appTitle: "Products",
      showDrawer: true,
      tabItems: _renderTab(),
      tabViews: _renderPage(),
      topPageControl: topPageControl,
      indicatorColor: Colors.white,
    );
  }
}
