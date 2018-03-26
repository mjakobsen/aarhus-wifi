import 'package:flutter/material.dart';

import '../helpers/wifi_getter_helper.dart';
import '../helpers/constants.dart';

import 'wifi_map_page.dart';

class WifiListPage extends StatefulWidget {

  WifiListPage({Key key}) : super(key: key);

  @override
  _WifiListPageState createState() => new _WifiListPageState();
}

class _WifiListPageState extends State<WifiListPage> {
  final _wifies = <WiFi>[];
  final _biggerFont = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  final _smallerFont = const TextStyle(fontSize: 15.0);
  final wifiManager = new WiFiManager();

  @override
  initState() {
    super.initState();
    listenForWifies();
  }

  listenForWifies() async {
    var fetchedWifies = await wifiManager.getSortedWifies();
    setState( () => _wifies.addAll(fetchedWifies.take(10)));
  }

  void _onShowMapPressed(){
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new WifiMapPage()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(appBarTitle),
      ),
      body: _buildWifiList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _onShowMapPressed,
        tooltip: 'Vis på kort',
        child: new Icon(Icons.map),
      ),
    );
  }

  Widget _buildWifiList() {
    return new ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: _wifies.length,
      itemBuilder: (context, i) {
        return _buildWifiRow(_wifies[i]);
      },
    );
  }

  Widget _buildWifiRow(WiFi wifi) {
    return new Column(
      children: [
        new ListTile(
          title: new Text(
            wifi.name,
            style: _biggerFont,
          ),
          subtitle: new Text(
            '${wifi.street} ${wifi.streetNo}, ${wifi.zipCode} ${wifi.city}',
            style: _smallerFont,
          ),
        ),
        _wifies.last != wifi ? new Divider() : new Container(),
      ],
    );
  }
}