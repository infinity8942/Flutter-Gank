import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank/models/Gank.dart';
import 'package:flutter_gank/models/GankItem.dart';
import 'package:flutter_gank/ui/comm/LoadingPage.dart';
import 'package:flutter_gank/ui/comm/MyWebview.dart';

enum AppBarBehavior { normal, pinned, floating, snapping }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final Map<String, List<GankItem>> ganks = Map<String, List<GankItem>>();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    await Dio().get('http://gank.io/api/today').then((resp) {
      Gank gank = Gank.fromJson(resp.data);
      setState(() {
        ganks.addAll(gank.results);
      });
    }, onError: () {});
  }

  @override
  Widget build(BuildContext context) {
    AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 256.0,
          pinned: _appBarBehavior == AppBarBehavior.pinned,
          floating: _appBarBehavior == AppBarBehavior.floating ||
              _appBarBehavior == AppBarBehavior.snapping,
          snap: _appBarBehavior == AppBarBehavior.snapping,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Gank'),
            background: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                ganks['福利'] != null
                    ? CachedNetworkImage(
                        placeholder: Center(child: CircularProgressIndicator()),
                        imageUrl: ganks['福利'][0].url,
                        fit: BoxFit.cover,
                        height: 256.0,
                      )
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
        ganks.length == 0
            ? SliverFillRemaining(
                child: LoadingPage(),
              )
            : SliverList(
                delegate: SliverChildListDelegate(
                  _buildGroup(ganks),
                ),
              ),
      ],
    );
  }

  List<Widget> _buildGroup(Map<String, List<GankItem>> ganks) {
    final TextStyle titleStyle = TextStyle(
        fontSize: 16.0, color: Color(0xff333333), fontWeight: FontWeight.bold);
    List<Widget> widgets = <Widget>[];
    ganks.forEach((k, v) {
      if (k != '福利') {
        widgets.add(
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0),
                  child: Text(k, style: titleStyle),
                ),
                Container(
                  child: Column(
                    children: v.map((item) {
                      return ListTile(
                        title: Text(item.desc),
                        subtitle: Text(item.who),
                        onTap: () => Navigator
                                .of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return MyWebview(title: item.desc, url: item.url);
                            })),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
    return widgets;
  }
}
