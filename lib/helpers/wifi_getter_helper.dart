import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:queries/collections.dart';

class WiFi {
  int id;
  String department;
  String name;
  String street;
  String streetNo;
  String zipCode;
  String city;
  double latitude;
  double longitude;
  double distanceToLocation;

   WiFi.fromJson(Map jsonMap) {
      id = jsonMap['id'];
      department = jsonMap['department'];
      name = jsonMap['name'];
      street = jsonMap['street'];
      streetNo = jsonMap['no'];
      zipCode = jsonMap['zip'];
      city = jsonMap['city'];
      latitude = jsonMap['lat'];
      longitude = jsonMap['lng'];
   }

   String toString() => 'Wifi: $name';
}

class WiFiManager {
  List<WiFi> closeWifies = <WiFi>[];

  var _location = new Location();
  var _currentLocation = <String, double>{};

  _getCurrentLocation() async {
    try {
      _currentLocation = await _location.getLocation;
    } on PlatformException {
      _currentLocation = null;
    }
  }

  _calculateDistance(Map<String, double> currentLocation, WiFi currentWifi) {
    Point<double> wifiPoint = new Point<double>(currentWifi.latitude, currentWifi.longitude);
    Point<double> locationPoint = new Point<double>(currentLocation["latitude"], currentLocation["longitude"]);
    currentWifi.distanceToLocation = locationPoint.distanceTo(wifiPoint);
  }

  Future<List<WiFi>> getSortedWifies() async {
    _getCurrentLocation();
    var allWifies = await getWifies();
    allWifies.forEach((wifi) => _calculateDistance(_currentLocation, wifi));
    return new Collection(allWifies).orderBy((wifi) => wifi.distanceToLocation).toList();
  }

  Future<List<WiFi>> getWifies() async {
  var url = 'http://portal.opendata.dk/api/3/action/datastore_search?resource_id=5a4a9d62-b17e-4a7d-a249-f6a6bf11ef62';

  var http = new HttpClient();

  return http
    .getUrl(Uri.parse(url))
    .then( (req) => req.close())
    .then( (res) => res.transform(UTF8.decoder).join())
    .then( (json) {
      Map decodedJson = JSON.decode(json);
      return new List<WiFi>.from(
        new List.from(
          decodedJson['result']['records']
        ).map(
          (wifiRecord) => new WiFi.fromJson(wifiRecord)
        )
      );
    });
}
}
