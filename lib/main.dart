import 'dart:async';

import 'package:flutter/material.dart';

import './UI/wifi_list_page.dart';

import 'key.dart';

void main(){
  runApp(new MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new WifiListPage(),
    );
  }
}
