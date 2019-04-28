import 'package:flutter/material.dart';

class AmapSearch extends StatefulWidget {
  @override
  _AmapSearchState createState() => _AmapSearchState();
}

class _AmapSearchState extends State<AmapSearch> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('高德地图搜索'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(child: Text('高德地图搜索')),
      ),
    );
  }
}
