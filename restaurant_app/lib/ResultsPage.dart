import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:restaurant_app/Restaurant.dart';

class ResultsPage extends StatefulWidget {
  _ResultsPageState hP = new _ResultsPageState(lat, lon);
  @override
  _ResultsPageState createState() => hP;

  double _lat, _lon;
  ResultsPage(double lat, double lon) {
    _lat = lat;
    _lon = lon;

  }
  double get lat => _lat;
  double get lon => _lon;


}

class _ResultsPageState extends State<ResultsPage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  var url, request, response;
  String value, error;
  double _lat, _lon;

  _ResultsPageState(double lat, double lon) {
    _lat = lat;
    _lon = lon;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Set<Restaurant> restaurants;
    Future<Set<Restaurant>> rFuture = fetchRestaurants(_lat, _lon);
    rFuture.then((r) => restaurants = r);
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Center(
        child: new Text('$_lat $_lon'),
      ),
    );
  }

  Future<Set<Restaurant>> fetchRestaurants(double _lat, double _lon) async {
    Set<Restaurant> restaurants = new Set<Restaurant>();
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_lat},${_lon}&radius=500&type=restaurant&key=AIzaSyA7C9zgb1ORXIoFwMW8eDw0TIHjsKnyQ2c";
    print(url);
    final response = await http.get(url);
    //print(response.body);
    Map<String, dynamic> result = json.decode(response.body.toString());
    result['results'].forEach((rest) => restaurants.add(new Restaurant.fromJson(rest)));
    // if (restaurants.isNotEmpty) {
    //   print("ALL RECOVERED RESTAURANTS");
    //   restaurants.forEach((restaurant) => print(restaurant.name));
    // }
   return restaurants;
  }
}
