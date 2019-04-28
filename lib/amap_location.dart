import 'package:flutter/material.dart';

class AmapLocation extends StatefulWidget {
  @override
  _AmapLocationState createState() => _AmapLocationState();
}

class _AmapLocationState extends State<AmapLocation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('高德地图定位'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(child: Text('高德地图定位')),
      ),
    );
  }
}
