import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';
import 'package:restaurant_app/RestaurantCardViewer//RestaurantFetcher.dart';
import 'package:restaurant_app/RestaurantCardInfo/RestaurantList.dart';

//Holds all of the Restaurant Card Info in a page.
class ResultsPage extends StatefulWidget {
  _ResultsPageState _hP;
  @override
  _ResultsPageState createState() => _hP;

  double _lat, _lon;
  ResultsPage(double lat, double lon) {
    _lat = lat;
    _lon = lon;
    _hP = new _ResultsPageState(lat, lon, Set());
  }

  ResultsPage.cuisines(double lat, double lon, Set<String> _selectedCuisines) {
    _lat = lat;
    _lon = lon;
    _hP = new _ResultsPageState(lat, lon, _selectedCuisines);
  }
  double get lat => _lat;
  double get lon => _lon;
}

class _ResultsPageState extends State<ResultsPage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  //var url, request, response;
  //String value, error;
  double _lat, _lon;
  Set<String> _selectedCuisines;
  Set<Restaurant> restaurants;
  Future<Set<Restaurant>> rFuture;

  _ResultsPageState(this._lat, this._lon, this._selectedCuisines);

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    RestaurantFetcher rF = new RestaurantFetcher(_lat, _lon, _selectedCuisines);
    Set<Restaurant> rest = await rF.fetchRestaurants();
    setState(() => restaurants = rest);
  }

  @override
  Widget build(BuildContext context) {
    var child;
    double scaleFactor =
        1 / MediaQuery.of(context).devicePixelRatio; //change later

    if (restaurants != null && restaurants.length != 0) {
      child = RestaurantList(restaurants.toList());
    } else {
      child = new Center(
          child: new Text("Fetching data...",
              style: new TextStyle(fontSize: 70.0 * scaleFactor)));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
      body: new Container(child: child),
    );
  }
}
