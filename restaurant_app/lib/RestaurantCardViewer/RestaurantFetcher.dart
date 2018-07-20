import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';

class RestaurantFetcher {
  /// Fetches the restaurants given the latitude and longitude.
  double _lat, _lon;
  Set<Restaurant> _restaurants;
  RestaurantFetcher(double _lat, double _lon) {
    this._lat = _lat;
    this._lon = _lon;
  }

  Set<Restaurant> get restaurants => _restaurants;

  Future<Set<Restaurant>> fetchRestaurants() async {
    /// Gets each restaurant and places it into the Future<Set<Restaurant>>
    _restaurants = new Set<Restaurant>();
    var url =
        "https://api.yelp.com/v3/businesses/search?term=restaurant&latitude=$_lat&longitude=$_lon";
    print(url);
    var response = await http.get(
        url,
        headers: {HttpHeaders.AUTHORIZATION: "Bearer c8eYj3EGPOlR3xcHsDrcdvSI17QkI4NXtUPLuux006pN-MLKggrzpFyG42T2Y40geFAJn8shKLtYEg5GcRmlO6nAHhZ-rLpV1UqQv87T53-NNDIerPM2bOPSiz9FW3Yx"},
        );
    print(response.statusCode);
    Map<String, dynamic> result = json.decode(response.body.toString());
    result['businesses']
        .forEach((rest) => _restaurants.add(new Restaurant.fromJson(rest)));
    if (_restaurants.isNotEmpty) {
      _restaurants.forEach((restaurant) => print(restaurant.name));
    }
    return _restaurants;
  }
}
