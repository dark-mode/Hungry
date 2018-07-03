import 'package:flutter/material.dart';
import 'package:restaurant_app/Restaurant.dart';
import 'package:restaurant_app/RestaurantPage.dart';
//adapted from https://hackernoon.com/flutter-iii-lists-and-items-6bfa7348ab1b

class RestaurantList extends StatelessWidget {

  final List<Restaurant> _restaurants;

  RestaurantList(this._restaurants);

  @override
  Widget build(BuildContext context) {
  double scaleFactor =  1/MediaQuery.of(context).devicePixelRatio;
    return new ListView(
          padding: new EdgeInsets.symmetric(vertical: 20.0 * scaleFactor),
          children: _buildRestaurantList(scaleFactor, context)
        );
  }

  List<RestaurantListItem> _buildRestaurantList(double scaleFactor, BuildContext context) {
    return _restaurants.map((restaurant) => new RestaurantListItem(restaurant, scaleFactor, context))
                    .toList();
  }

}

class RestaurantListItem extends Card {
  RestaurantListItem(Restaurant restaurant, double scaleFactor, BuildContext context):
    super(
        margin: EdgeInsets.only(top: 20.0 * scaleFactor, bottom: 20.0 * scaleFactor, left: 25.0 * scaleFactor, right: 25.0 * scaleFactor),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.push(context, new MyCustomRoute(
                  builder: (BuildContext context) => new RestaurantPage(restaurant)),);
                },
              contentPadding: EdgeInsets.symmetric(vertical: 55.0 * scaleFactor, horizontal: 60.0 * scaleFactor),
              leading: const Icon(Icons.album),
              title:  new Text(
                  restaurant.name,
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 65.0 * scaleFactor,
                  )
                ),
              subtitle: new Text(
                restaurant.address,
                textAlign: TextAlign.left,
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 40.0 * scaleFactor,
                  )
                ),
            ),
          ],
        ),
    );

}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  //@src https://stackoverflow.com/questions/43680902/replace-initial-route-in-materialapp-without-animation/43685697#43685697
  MyCustomRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (settings.isInitialRoute)
      return child;
    // Fades between routes. (If you don't want any animation, 
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}