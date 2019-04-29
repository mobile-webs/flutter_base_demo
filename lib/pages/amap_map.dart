import 'package:amap_base/amap_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_demo/widgets/setting.widget.dart';

class AmapMapPage extends StatefulWidget {
  @override
  _AmapMapPageState createState() => _AmapMapPageState();
}

class _AmapMapPageState extends State<AmapMapPage> {
  AMapController _controller;
  UiSettings _uiSettings = UiSettings();

  @override
  void dispose() {
    _controller.dispose();
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
          title: Text('高德地图'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: AMapView(
                onAMapViewCreated: (controller) {
                  setState(() => _controller = controller);
                  _controller?.setPosition(
                      zoom: 16, target: LatLng(34.259596, 108.946876));
                },
                amapOptions: AMapOptions(),
              ),
            ),
            Flexible(
                child: ListView(
              children: <Widget>[
                DiscreteSetting(
                  head: '地图图层 [Android, iOS]',
                  options: [
                    '导航地图',
                    '夜景地图',
                    '白昼地图（即普通地图）',
                    '卫星图',
                  ],
                  onSelected: (value) {
                    int mapType;
                    switch (value) {
                      case '导航地图':
                        mapType = MAP_TYPE_NAVI;
                        break;
                      case '夜景地图':
                        mapType = MAP_TYPE_NIGHT;
                        break;
                      case '白昼地图（即普通地图）':
                        mapType = MAP_TYPE_NORMAL;
                        break;
                      case '卫星图':
                        mapType = MAP_TYPE_SATELLITE;
                        break;
                    }
                    _controller.setMapType(mapType);
                  },
                ),
                BooleanSetting(
                  head: '显示自己的位置 [Android, iOS]',
                  onSelected: (value) async {
                    if (await Permissions().requestPermission()) {
                      _controller?.setMyLocationStyle(
                          MyLocationStyle(showMyLocation: value));
                    } else {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('权限不足')));
                    }
                  },
                ),
                BooleanSetting(
                  head: '缩放按钮 [Android]',
                  selected: _uiSettings.isZoomControlsEnabled,
                  onSelected: (value) {
                    _controller?.setUiSettings(
                        _uiSettings.copyWith(isZoomControlsEnabled: value));
                  },
                ),
                DiscreteSetting(
                  head: '缩放按钮位置 [Android]',
                  options: ['右中', '右下'],
                  onSelected: (value) {
                    int position;
                    switch (value) {
                      case '右中':
                        position = ZOOM_POSITION_RIGHT_CENTER;
                        break;
                      case '右下':
                        position = ZOOM_POSITION_RIGHT_BUTTOM;
                        break;
                    }
                    _controller?.setUiSettings(
                        _uiSettings.copyWith(zoomPosition: position));
                  },
                ),
                BooleanSetting(
                  head: '指南针 [Android, iOS]',
                  selected: _uiSettings.isCompassEnabled,
                  onSelected: (value) {
                    _controller?.setUiSettings(
                        _uiSettings.copyWith(isCompassEnabled: value));
                  },
                ),
                BooleanSetting(
                  head: '定位按钮 [Android]',
                  selected: _uiSettings.isMyLocationButtonEnabled,
                  onSelected: (value) {
                    _controller?.setUiSettings(
                        _uiSettings.copyWith(isMyLocationButtonEnabled: value));
                  },
                ),
                BooleanSetting(
                  head: '比例尺控件 [Android, iOS]',
                  selected: _uiSettings.isScaleControlsEnabled,
                  onSelected: (value) {
                    _controller?.setUiSettings(
                        _uiSettings.copyWith(isScaleControlsEnabled: value));
                  },
                ),
                DiscreteSetting(
                  head: '地图Logo [Android]',
                  options: ['左下', '中下', '右下'],
                  onSelected: (value) {
                    int position;
                    switch (value) {
                      case '左下':
                        position = LOGO_POSITION_BOTTOM_LEFT;
                        break;
                      case '中下':
                        position = LOGO_POSITION_BOTTOM_CENTER;
                        break;
                      case '右下':
                        position = LOGO_POSITION_BOTTOM_RIGHT;
                        break;
                    }
                    _controller?.setUiSettings(
                        _uiSettings.copyWith(logoPosition: position));
                  },
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
