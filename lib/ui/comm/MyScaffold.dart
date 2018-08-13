import 'package:flutter/material.dart';
import 'package:flutter_gank/ui/comm/MyDrawer.dart';

class MyScaffold extends StatelessWidget {
  final appTitle;
  final Widget appBar;
  final Widget bodyData;
  final showDrawer;
  final backGroundColor;
  final actionFirstIcon;
  final scaffoldKey;
  final showBottomNav;
  final floatingIcon;
  final centerDocked;
  final elevation;

  MyScaffold(
      {this.appTitle,
      this.bodyData,
        this.appBar,
        this.showDrawer,
      this.backGroundColor,
      this.actionFirstIcon = Icons.search,
      this.scaffoldKey,
      this.showBottomNav = false,
      this.centerDocked = false,
      this.floatingIcon,
      this.elevation = 5.0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey != null ? scaffoldKey : null,
      backgroundColor: backGroundColor != null ? backGroundColor : null,
      appBar: appBar != null
          ? appBar
          : AppBar(
        elevation: elevation,
        title: Text(appTitle),
        actions: <Widget>[
          SizedBox(
            width: 5.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(actionFirstIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      drawer: showDrawer ? MyDrawer() : null,
      body: bodyData,
      floatingActionButton: null,
      bottomNavigationBar: null,
    );
  }
}
