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
          children: _buildRestaurantList(context)
        );
  }

  List<RestaurantListItem> _buildRestaurantList(BuildContext context) {
  double scaleFactor =  1/MediaQuery.of(context).devicePixelRatio;
    return _restaurants.map((restaurant) => new RestaurantListItem(restaurant, scaleFactor))
                    .toList();
  }

}

class RestaurantListItem extends Card {
  RestaurantListItem(Restaurant restaurant, double scaleFactor) :
    super(
        margin: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              leading: const Icon(Icons.album),
              title:  new Text(
                  restaurant.name,
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 65.0*scaleFactor,
                  )
                ),
              subtitle: new Text(
                restaurant.address,
                textAlign: TextAlign.left,
                ),
            ),
          ],
        ),
    );

}