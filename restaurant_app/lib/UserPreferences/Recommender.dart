import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';
import 'package:restaurant_app/UserPreferences/User.dart';

class Recommender {
  User user;
  Set<Restaurant> restaurants;
  Recommender(User user, Set<Restaurant> restaurants) {
    this.user = user;
    this.restaurants = restaurants;
  }
}
