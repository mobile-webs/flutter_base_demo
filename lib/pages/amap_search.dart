import 'package:amap_base/amap_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_demo/utils/misc.dart';
import 'package:flutter_base_demo/utils/view.dart';
import 'package:flutter_base_demo/widgets/button.widget.dart';

class AmapSearch extends StatefulWidget {
  @override
  _AmapSearchState createState() => _AmapSearchState();
}

class _AmapSearchState extends State<AmapSearch> {
  String _result = '';
  GeocodeAddressList _searchResult;
  LatLng _searchLatLng;

  TextEditingController _nameController = TextEditingController(text: '天安门');
  TextEditingController _cityController = TextEditingController(text: '北京市');

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
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
          title: Text('高德地图地理编码'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Form(
                child: ListView(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '输入目标地址',
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.black54),
                  controller: _nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return '输入目标地址';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '输入所在城市',
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.black54),
                  controller: _cityController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return '输入所在城市';
                    }
                  },
                ),
                Button(
                  label: '开始搜索',
                  onPressed: (context) async {
                    if (!Form.of(context).validate()) {
                      return;
                    }
                    loading(
                      context,
                      AMapSearch().searchGeocode(
                        _nameController.text,
                        _cityController.text,
                      ),
                    ).then((result) {
                      setState(() {
                        _result = jsonFormat(result.toJson());
                        _searchResult = result.geocodeAddressList[0];
                        _searchLatLng = result.geocodeAddressList[0].latLng;
                      });
                    }).catchError((e) => showError(context, e.toString()));
                  },
                ),
                Text('城市：${_searchResult?.city ?? '暂无'}',
                    style: TextStyle(color: Colors.black54)),
                Text(
                    '经度：${_searchLatLng != null ? _searchLatLng.longitude.toString() : '暂无'}',
                    style: TextStyle(color: Colors.black54)),
                Text(
                    '纬度：${_searchLatLng != null ? _searchLatLng.latitude.toString() : '暂无'}',
                    style: TextStyle(color: Colors.black54)),
                Text(_result, style: TextStyle(color: Colors.black54)),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
