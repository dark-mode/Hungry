import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  double _lat, _lon;
  ResultsPage(double lat, double lon) {
    _lat = lat;
    _lon = lon;

  }

  double get lat => _lat;
  double get lon => _lon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Center(
        child: new Text('$_lat $_lon'),
      ),
    );
  }
}
