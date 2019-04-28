import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_demo/advanced_list_page.dart';
import 'package:flutter_base_demo/amap_location.dart';
import 'package:flutter_base_demo/amap_search.dart';
import 'package:flutter_base_demo/animation_page.dart';
import 'package:flutter_base_demo/az_list_page.dart';
import 'package:flutter_base_demo/dio_page.dart';
import 'package:flutter_base_demo/expansion_title_page.dart';
import 'package:flutter_base_demo/flutter_layout_page.dart';
import 'package:flutter_base_demo/future_page.dart';
import 'package:flutter_base_demo/gesture_page.dart';
import 'package:flutter_base_demo/grid_view_page.dart';
import 'package:flutter_base_demo/hero_animation_page.dart';
import 'package:flutter_base_demo/http_page.dart';
import 'package:flutter_base_demo/launch_page.dart';
import 'package:flutter_base_demo/less_group_page.dart';
import 'package:flutter_base_demo/list_page.dart';
import 'package:flutter_base_demo/photo_app_page.dart';
import 'package:flutter_base_demo/plugin_use.dart';
import 'package:flutter_base_demo/resource_page.dart';
import 'package:flutter_base_demo/shared_preferences_page.dart';
import 'package:flutter_base_demo/stateful_group_page.dart';
import 'package:flutter_base_demo/tabbed_app_bar_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('这是标题'),
          ),
          body: RouteNavigator()),
      routes: <String, WidgetBuilder>{
        'plugin': (BuildContext context) => PluginUsePage(),
        'less': (BuildContext context) => StateLessGroupPage(),
        'ful': (BuildContext context) => StateFulGroupPage(),
        'layout': (BuildContext context) => FlutterLayoutPage(),
        'gesture': (BuildContext context) => GesturePage(),
        'resource': (BuildContext context) => ResourcePage(),
        'launch': (BuildContext context) => LaunchPage(),
        'photo': (BuildContext context) => PhotoAppPage(),
        'animation': (BuildContext context) => AnimationPage(),
        'hero': (BuildContext context) => HeroAnimationPage(),
        'radialHero': (BuildContext context) => RadialExpansionDemo(),
        'tabbedAppBar': (BuildContext context) => TabbedAppBarPage(),
        'http': (BuildContext context) => TestHttp(),
        'future': (BuildContext context) => TestFuture(),
        'sharedPreferences': (BuildContext context) => TestSharedPreferences(),
        'list': (BuildContext context) => ListPage(),
        'expansionTitle': (BuildContext context) => ExpansionTitlePage(),
        'gridView': (BuildContext context) => GridViewPage(),
        'advancedList': (BuildContext context) => AdvancedListPage(),
        'dio': (BuildContext context) => DioPage(),
        'amapLocation': (BuildContext context) => AmapLocation(),
        'amapSearch': (BuildContext context) => AmapSearch(),
        'azList': (BuildContext context) => AzListPage(),
      },
    );
  }
}

class RouteNavigator extends StatefulWidget {
  @override
  _RouteNavigatorState createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  bool byName = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
            title: Text('${byName ? '' : '不'}通过路由名称跳转'),
            value: byName,
            onChanged: (value) {
              setState(() {
                byName = value;
              });
            }),
        Flexible(
          child: GridView.count(
            crossAxisCount: 3,
            children: <Widget>[
              _item('plugin使用', PluginUsePage(), 'plugin'),
              _item('StatelessWidget与基础组件', StateLessGroupPage(), 'less'),
              _item('StateFulWidget与基础组件', StateFulGroupPage(), 'ful'),
              _item('如何进行Flutter布局开发', FlutterLayoutPage(), 'layout'),
              _item('用户手势及点击事件', GesturePage(), 'gesture'),
              _item('导入和使用Flutter的资源文件', ResourcePage(), 'resource'),
              _item('打开第三方应用', LaunchPage(), 'launch'),
              _item('photo', PhotoAppPage(), 'photo'),
              _item('顶部tab', TabbedAppBarPage(), 'tabbedAppBar'),
              _item('http使用', TestHttp(), 'http'),
              _item('future使用', TestHttp(), 'future'),
              _item('sharedPreferences使用', TestSharedPreferences(),
                  'sharedPreferences'),
              _item('基础list使用', ListPage(), 'list'),
              _item('高级列表使用', AdvancedListPage(), 'advancedList'),
              _item('expansionTitle使用', ExpansionTitlePage(), 'expansionTitle'),
              _item('网格布局', GridViewPage(), 'gridView'),
              _item('dio使用', DioPage(), 'dio'),
              _item('高德地图定位', AmapLocation(), 'amapLocation'),
              _item('高德地图搜索', AmapSearch(), 'amapSearch'),
              _item('城市索引', AzListPage(), 'azList'),
              _item('普通动画', AnimationPage(), 'animation'),
              _item('hero动画', HeroAnimationPage(), 'hero'),
              _item('径向hero动画', RadialExpansionDemo(), 'radialHero'),
            ],
          ),
        )
      ],
    );
  }

  _item(String title, Widget page, String routeName) {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        color: Colors.indigo,
        onPressed: () {
          if (byName) {
            Navigator.pushNamed(context, routeName);
          } else {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => page));
          }
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
