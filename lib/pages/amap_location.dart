import 'dart:convert';

import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_demo/utils/misc.dart';
import 'package:flutter_base_demo/widgets/button.widget.dart';

class AmapLocationPage extends StatefulWidget {
  @override
  _AmapLocationPageState createState() => _AmapLocationPageState();
}

class _AmapLocationPageState extends State<AmapLocationPage> {
  final _amapLocation = AMapLocation();
  List<Location> _result = [];

  @override
  void dispose() {
    _amapLocation.stopLocate();
    super.dispose();
  }

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: ListView(
                children:
                    _result.map((location) => _ResultItem(location)).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button(
                  label: '单次定位',
                  onPressed: (context) async {
                    final options = LocationClientOptions(
                      isOnceLocation: true,
                      locatingWithReGeocode: true,
                    );
                    if (await Permissions().requestPermission()) {
                      _amapLocation
                          .getLocation(options)
                          .then(_result.add)
                          .then((_) => setState(() {}));
                    } else {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('权限不足')));
                    }
                  },
                ),
                Button(
                  label: '连续定位',
                  onPressed: (context) async {
                    final options = LocationClientOptions(
                      isOnceLocation: false,
                      locatingWithReGeocode: true,
                    );

                    if (await Permissions().requestPermission()) {
                      _amapLocation
                          .startLocate(options)
                          .map(_result.add)
                          .listen((_) => setState(() {}));
                    } else {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('权限不足')));
                    }
                  },
                ),
                Button(
                  label: '停止定位',
                  onPressed: (context) {
                    _amapLocation.stopLocate();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ResultItem extends StatelessWidget {
  final Location _data;

  const _ResultItem(this._data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            DateTime.now().toIso8601String(),
            style: TextStyle(color: Colors.grey),
          ),
          Text(_data.errorInfo),
          Text(
            jsonFormat(_data.toJson()),
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
