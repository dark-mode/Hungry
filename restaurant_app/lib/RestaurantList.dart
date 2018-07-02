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

class RestaurantListItem extends Card {

  RestaurantListItem(Restaurant restaurant) :
    super(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              
              contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              leading: const Icon(Icons.album),
              title:  new Text(
                  restaurant.name,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  )
                ),
              subtitle: Text(restaurant.address),
            ),
          ],
        ),
    );

}