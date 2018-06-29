import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  _HomePageState hP = new _HomePageState();
  @override
  _HomePageState createState() => hP;
}

class _HomePageState extends State<HomePage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  Map<String, double> _startLocation;

  Location _location = new Location();
  double _lon, _lat;
  String value, error;
  var restaurants = new Set();

  bool currentWidget = true;

  Image image1;

  double get lon => _lon;
  double get lat => _lat;

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      location = await _location.getLocation;
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    setState(() {
        _startLocation = location;
        _lon = location['longitude'];
        _lat = location['latitude'];
    });

  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('$_lon $_lat'),
          onPressed: () {

            // Navigate to second screen when tapped!
            Navigator.pushReplacementNamed(
              context,
              "/results");
          },
        ),
      ),
    );
  }
}