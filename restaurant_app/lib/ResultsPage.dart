import 'package:flutter/material.dart';
import 'dart:async';
import 'package:restaurant_app/Restaurant.dart';
import 'package:restaurant_app/RestaurantList.dart';
import 'package:restaurant_app/RestaurantFetcher.dart';

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
      RestaurantFetcher rF = new RestaurantFetcher(_lat, _lon);
      Set<Restaurant> rest = await rF.fetchRestaurants();
      
    setState(() => restaurants = rest
    );
    print("we did it!");

  }

  @override
  Widget build(BuildContext context) {
      var child;
      double scaleFactor =  1/MediaQuery.of(context).devicePixelRatio; //change later
      
      if (restaurants != null && restaurants.length != 0) {
        child = new RestaurantList(restaurants.toList());
      } else {
        child = new Center(
          child: new Text("Fetching data...", 
            style: new TextStyle(
              fontSize: 70.0 * scaleFactor
            )
          )
        );
      }
      return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
      body: new Container (
        child: child
      ),
    );
  }
}
