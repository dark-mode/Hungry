import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  double _lon, _lat;
  ResultsPage(double lon, double lat) {
    _lon = lon;
    _lat = lat;
  }

  double get lon => _lon;
  double get lat => _lat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
      ),
    );
  }
}
