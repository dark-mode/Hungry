import 'package:restaurant_app/Restaurant.dart';
import 'package:restaurant_app/User.dart';

class Recommender {
  User user;
  Set<Restaurant> restaurants;
  Recommender(User user, Set<Restaurant> restaurants) {
    this.user = user;
    this.restaurants = restaurants;
  }
}