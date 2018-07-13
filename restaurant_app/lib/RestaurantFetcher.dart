import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:restaurant_app/Restaurant.dart';

class RestaurantFetcher {
  double _lat, _lon;
  Set<Restaurant> _restaurants;
  RestaurantFetcher(double _lat, double _lon) {
    this._lat = _lat;
    this._lon = _lon;
    fetchRestaurants();
  }

  Set<Restaurant> get restaurants => _restaurants;

  Future<Set<Restaurant>> fetchRestaurants() async {
    _restaurants = new Set<Restaurant>();
    var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_lat},${_lon}&radius=1500&type=restaurant&key=AIzaSyA7C9zgb1ORXIoFwMW8eDw0TIHjsKnyQ2c";
    print(url);
    var response = await http.get(url);
    Map<String, dynamic> result = json.decode(response.body.toString());
    result['results'].forEach((rest) => _restaurants.add(new Restaurant.fromJson(rest)));
    if (_restaurants.isNotEmpty) {
      print("ALL RECOVERED RESTAURANTS");
      _restaurants.forEach((restaurant) => print(restaurant.name));
    }
    return _restaurants;
  }
}