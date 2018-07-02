import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:restaurant_app/Restaurant.dart';
import 'package:restaurant_app/RestaurantList.dart';

class ResultsPage extends StatefulWidget {
  _ResultsPageState hP;
  @override
  _ResultsPageState createState() => hP;

  double _lat, _lon;
  ResultsPage(double lat, double lon) {
    _lat = lat;
    _lon = lon;
    hP = new _ResultsPageState(lat, lon);
  }
  double get lat => _lat;
  double get lon => _lon;


}

class _ResultsPageState extends State<ResultsPage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  var url, request, response;
  String value, error;
  double _lat, _lon;
  Set<Restaurant> restaurants;
  Future<Set<Restaurant>> rFuture;

  _ResultsPageState(double lat, double lon) {
    _lat = lat;
    _lon = lon;
  }

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

    initPlatformState() async {
      Set<Restaurant> rest = await fetchRestaurants(_lat, _lon);
      
    setState(() {
      //rFuture.then((r) => restaurants = r);
      restaurants = rest;
      }
    );
    print("we did it!");

  }

  @override
  Widget build(BuildContext context) {
      //RestaurantList rl = new RestaurantList(restaurants.toList());
      String firstRest = "Fetching Data...";
      
      if (restaurants != null && restaurants.length != 0) {
        firstRest = restaurants.first.name;
      }
      return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: new Container (
       // padding: EdgeInsets.all(20.0),
        child: new RestaurantList(restaurants.toList())
      ),
    );
  }


  Future<Set<Restaurant>> fetchRestaurants(double _lat, double _lon) async {
    Set<Restaurant> restaurants = new Set<Restaurant>();
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_lat},${_lon}&radius=1500&type=restaurant&key=AIzaSyA7C9zgb1ORXIoFwMW8eDw0TIHjsKnyQ2c";
    print(url);
    final response = await http.get(url);
    //print(response.body);
    Map<String, dynamic> result = json.decode(response.body.toString());
    result['results'].forEach((rest) => restaurants.add(new Restaurant.fromJson(rest)));
     if (restaurants.isNotEmpty) {
       print("ALL RECOVERED RESTAURANTS");
       restaurants.forEach((restaurant) => print(restaurant.name));
     }
   return restaurants;
  }
}
