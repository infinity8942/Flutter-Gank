import 'package:flutter/material.dart';
import 'package:flutter_gank/config/AppOptions.dart';
import 'package:flutter_gank/ui/android/Android.dart';
import 'package:flutter_gank/ui/book/Book.dart';
import 'package:flutter_gank/ui/home//Gank.dart';
import 'package:flutter_gank/ui/home/Home.dart';
import 'package:flutter_gank/ui/ios/Ios.dart';
import 'package:flutter_gank/ui/login/Login.dart';
import 'package:flutter_gank/ui/login/Splash.dart';
import 'package:flutter_gank/ui/setting/Setting.dart';
import 'package:flutter_gank/ui/video/VideoPage.dart';
import 'package:flutter_gank/ui/web/Web.dart';
import 'package:flutter_gank/ui/welfare/Welfare.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppOptions _appOpt;

  void _handleOptChanged(AppOptions _newOpt) {
    setState(() {
      _appOpt = _newOpt;
    });
  }

  @override
  void initState() {
    super.initState();

    _appOpt = AppOptions(
        appTheme: AppTheme(ThemeData().copyWith(primaryColor: Colors.blue)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gank',
      theme: _appOpt.appTheme.themeData,
      home: Slpash(),
      routes: <String, WidgetBuilder>{
        '/login': (_) => Login(),
        '/main': (_) => Main(),
        '/home': (_) => Home(),
//        '/product_detail': (_) => Home(),
        '/setting': (_) =>
            Setting(appOpt: _appOpt, onOptionsChanged: _handleOptChanged),
        '/android': (_) => AndroidPage(),
        '/ios': (_) => Ios(),
        '/web': (_) => Web(),
        '/welfare': (_) => Welfare(),
        '/video': (_) => VideoPage(),
        '/book': (_) => Book()
      },
    );
  }
}
