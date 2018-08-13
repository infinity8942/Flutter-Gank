import 'package:flutter/material.dart';
import 'package:flutter_gank/ui/comm/MyDrawer.dart';

class MyTabBar extends StatefulWidget {
  final scaffoldKey;
  final appTitle;
  final showDrawer;
  final List<Widget> tabItems;
  final List<Widget> tabViews;
  final Color indicatorColor;
  final Widget floatingActionButton;
  final TarWidgetControl tarWidgetControl;
  final PageController topPageControl;

  MyTabBar({
    Key key,
    this.appTitle,
    this.scaffoldKey,
    this.showDrawer,
    this.tabItems,
    this.tabViews,
    this.indicatorColor,
    this.floatingActionButton,
    this.tarWidgetControl,
    this.topPageControl,
  }) : super(key: key);

  @override
  _MyTabBar createState() => new _MyTabBar(scaffoldKey, appTitle, showDrawer,
      tabItems, tabViews, indicatorColor, floatingActionButton, topPageControl);
}

class _MyTabBar extends State<MyTabBar> with SingleTickerProviderStateMixin {
  final scaffoldKey;
  final appTitle;
  final showDrawer;
  final List<Widget> _tabItems;
  final List<Widget> _tabViews;
  final Color _indicatorColor;
  final Widget _floatingActionButton;
  final PageController _pageController;

  _MyTabBar(
      this.scaffoldKey,
      this.appTitle,
      this.showDrawer,
      this._tabItems,
      this._tabViews,
      this._indicatorColor,
      this._floatingActionButton,
      this._pageController)
      : super();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: _tabItems.length);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      drawer: showDrawer ? MyDrawer() : null,
      floatingActionButton: _floatingActionButton,
      appBar: new AppBar(
        title: Text(appTitle),
        bottom: new TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: _tabItems,
          indicatorColor: _indicatorColor,
        ),
      ),
      body: new PageView(
        controller: _pageController,
        children: _tabViews,
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
