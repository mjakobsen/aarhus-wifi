import 'package:flutter/material.dart';

import '../helpers/wifi_getter_helper.dart';
import '../helpers/constants.dart';

class WifiMapPage extends StatefulWidget {
  WifiMapPage({Key key}) : super(key: key);

  @override
  _WifiMapPageState createState() => new _WifiMapPageState();
}

class _WifiMapPageState extends State<WifiMapPage> {

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(appBarTitle),
      ),
      body: new Text('Hello map world'),
    );
  }
}