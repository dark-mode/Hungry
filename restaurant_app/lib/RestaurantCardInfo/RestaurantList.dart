import 'package:flutter/material.dart';
import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';
import 'package:restaurant_app/RestaurantCardInfo/RestaurantListItem.dart';
//adapted from https://hackernoon.com/flutter-iii-lists-and-items-6bfa7348ab1b

class RestaurantList extends StatelessWidget {
  final List<Restaurant> _restaurants;

  RestaurantList(this._restaurants);

  @override
  Widget build(BuildContext context) {
    double scaleFactor = 1 / MediaQuery.of(context).devicePixelRatio;
    return new ListView(
        padding: new EdgeInsets.symmetric(vertical: 20.0 * scaleFactor),
        children: _buildRestaurantList(scaleFactor, context));
  }

  List<RestaurantListItem> _buildRestaurantList(
      double scaleFactor, BuildContext context) {
    return _restaurants
        .map((restaurant) =>
            new RestaurantListItem(restaurant, scaleFactor, context))
        .toList();
  }
}
