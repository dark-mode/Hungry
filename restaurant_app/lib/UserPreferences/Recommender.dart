import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';
import 'package:restaurant_app/UserPreferences/User.dart';
import 'dart:math';

/// Recommends restaurants based on user information.
class Recommender {
  User _user;
  Set<Restaurant> _restaurants;

  //Price, Distance (walking/driving), Rating

  Recommender(this._user, this._restaurants);

  List<Restaurant> runAlgorithm() {
    Map<Restaurant, double> scoredRestaurants = Map();
    double score;
    List<double> coord1 = createCoord1();
    List<double> coord2;
    List<Restaurant> r = _restaurants.toList();

    for (Restaurant rest in _restaurants) {
      coord2 = createCoord2(rest);
      score = euclideanDistance(coord1, coord2);
      scoredRestaurants[rest] = score;
    }

  }

  List<double> createCoord1() {
    //Scaled to 10
    return [_user.price * 2.5, 0.0, 5.0];
  }

  List<double> createCoord2(Restaurant rest) {
    double distanceMultiplier;
    distanceMultiplier = ((_user.price == "Walking") ? 700.0 : 16000.0) * 10.0;

    return [rest.price * 2.5, rest.distance * distanceMultiplier, rest.rating];
  }

  double euclideanDistance(List<double> coord1, List<double> coord2) {
    assert(coord1.length == coord2.length);
    double result = 0;
    for (int i = 0; i < coord1.length; i++) {
      result += pow(coord1[i] - coord2[i], 2);
    }
    return sqrt(result);
  }

}
