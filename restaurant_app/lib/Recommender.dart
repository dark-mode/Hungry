import 'package:restaurant_app/Restaurant.dart';
import 'package:restaurant_app/User.dart';

class Recommender {
  User user;
  Restaurant restaurant;
  Recommender(User user, Restaurant restaurant) {
    this.user = user;
    this.restaurant = restaurant;
  }

}