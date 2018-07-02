import 'package:flutter/material.dart';
import 'package:restaurant_app/Restaurant.dart';
//adapted from https://hackernoon.com/flutter-iii-lists-and-items-6bfa7348ab1b

class RestaurantList extends StatelessWidget {

  final List<Restaurant> _restaurants;

  RestaurantList(this._restaurants);

  @override
  Widget build(BuildContext context) {
    return new ListView(
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children: _buildRestaurantList()
        );
  }

  List<RestaurantListItem> _buildRestaurantList() {
    return _restaurants.map((restaurant) => new RestaurantListItem(restaurant))
                    .toList();
  }

}

class RestaurantListItem extends ListTile {

  RestaurantListItem(Restaurant restaurant) :
    super(
      title : new Text(restaurant.name),
      subtitle: new Text(restaurant.address),
      leading: new CircleAvatar(
        child: new Text(restaurant.name.substring(0, 1))
      )
    );

}