import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';
import 'package:restaurant_app/UserPreferences/User.dart';
import 'dart:math';

/// Recommends restaurants based on user information.
class Recommender {
  User _user;
  Set<Restaurant> _restaurants;

  //Price, Distance (walking/driving), Rating

  Recommender(this._user, Set<Restaurant> rest) {
    _restaurants = (rest == null) ? Set() : rest;
  }

  List<Restaurant> runAlgorithm() {
    Map<double, Restaurant> scoredRestaurants = Map();
    double score;
    List<double> coord1 = createCoord1();
    List<double> coord2;
    List<double> keys;
    List<Restaurant> restaurants = [];

    for (Restaurant rest in _restaurants) {
      coord2 = createCoord2(rest);
      score = euclideanDistance(coord1, coord2);
      scoredRestaurants[score] = rest;
    }

    keys = scoredRestaurants.keys.toList();
    keys.sort();
    for (double key in keys)
      restaurants.add(scoredRestaurants[key]);

    return restaurants;
  }

  List<double> createCoord1() {
    //Scaled to 10
    if (_user == null) return [5.0, 0.0, 10.0];
    return [_user.price * 2.5, 0.0, 10.0];
  }

  List<double> createCoord2(Restaurant rest) {
    double distanceMultiplier;
    distanceMultiplier = ((_user == null || _user.price == "Driving") ? 32186.9 : 700.0) / 10.0;
    if (rest.price == null || rest.distance == null || rest.rating == null) {
      return [10.0, 10.0, 10.0];
    }
    double distance = (rest.distance < 4828.03) ? 1.0 : rest.distance;
    double rating = (rest.reviewCount < 20) ? min(rest.rating - 2.0, 3.0) : rest.rating;

    return [rest.price * 2.5, distance / distanceMultiplier, min((rest.reviewCount * 1.5)/500.0, 1.5) + (rating/5 * 8.5)];
  }

  double euclideanDistance(List<double> coord1, List<double> coord2) {
    assert(coord1.length == coord2.length);
    double result = 0.0;
    for (int i = 0; i < coord1.length; i++) {
      result += pow(coord1[i] - coord2[i], 2);
    }
    return sqrt(result);
  }

}
