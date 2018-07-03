import 'package:flutter/material.dart';
import 'package:restaurant_app/Restaurant.dart';

Restaurant restaurant;

class RestaurantPage extends StatefulWidget {
  _RestaurantPageState rP = new _RestaurantPageState();
  @override
  _RestaurantPageState createState() => rP;

  RestaurantPage(Restaurant r) {
    restaurant = r;
  }
}

class _RestaurantPageState extends State<RestaurantPage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);
  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: Center(
        child: Text("This is the Restaurant Page."),
      ),
    );
  }
}