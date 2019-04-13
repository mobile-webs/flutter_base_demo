import 'package:flutter/material.dart';
import './plugin_use.dart';
import './less_group_page.dart';
import './stateful_group_page.dart';
import './flutter_layout_page.dart';

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
    return Container(
      child: Column(
        children: <Widget>[
          SwitchListTile(
            title: Text('${byName ? '' : '不'}通过路由名称跳转'),
            value: byName,
            onChanged: (value) {
              setState(() {
                byName = value;
              });
            },
          ),
          _item('plugin使用', PluginUsePage(), 'plugin'),
          _item('StatelessWidget与基础组件', StateLessGroupPage(), 'less'),
          _item('StateFulWidget与基础组件', StateFulGroupPage(), 'ful'),
          _item('如何进行Flutter布局开发', FlutterLayoutPage(), 'layout'),
        ],
      ),
    );
  }

  _item(String title, Widget page, String routeName) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (byName) {
            Navigator.pushNamed(context, routeName);
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}
