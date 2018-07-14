import 'package:flutter/material.dart';
import 'package:restaurant_app/MyCustomRoute.dart';
import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';
import 'package:restaurant_app/RestaurantCardInfo/RestaurantPage.dart';

/// Creates one restaurant card
class RestaurantListItem extends Card {
  RestaurantListItem(
      Restaurant restaurant, double scaleFactor, BuildContext context)
      : super(
          margin: EdgeInsets.only(
              top: 20.0 * scaleFactor,
              bottom: 20.0 * scaleFactor,
              left: 25.0 * scaleFactor,
              right: 25.0 * scaleFactor),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    new MyCustomRoute(
                        builder: (BuildContext context) =>
                            new RestaurantPage(restaurant)),
                  );
                },
                contentPadding: EdgeInsets.symmetric(
                    vertical: 55.0 * scaleFactor,
                    horizontal: 60.0 * scaleFactor),
                leading: const Icon(Icons.album),
                title: new Text(restaurant.name,
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 65.0 * scaleFactor,
                    )),
                subtitle: new Text(restaurant.address,
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 40.0 * scaleFactor,
                    )),
              ),
            ],
          ),
        );
}
