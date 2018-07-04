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
    double width =  MediaQuery.of(context).size.width;
    double height =  (MediaQuery.of(context).size.height/4);
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body:
      new Container(
    width: width,
    height: height,
    padding: EdgeInsets.symmetric(vertical: 50.0),
    decoration: new BoxDecoration(
      borderRadius: new BorderRadius.circular(30.0),
      color: const Color(0xff7c94b6),
      image: new DecorationImage(
        image: new NetworkImage(
            "https://maps.googleapis.com/maps/api/place/photo?maxwidth=${width.round()}&photoreference=${restaurant.photoReference}&key=AIzaSyA7C9zgb1ORXIoFwMW8eDw0TIHjsKnyQ2c"),
        fit: BoxFit.cover,
      ),
    ),
  ),
        // Image.network(
        //   'https://maps.googleapis.com/maps/api/place/photo?maxwidth=${width.round()}&photoreference=${restaurant.photoReference}&key=AIzaSyA7C9zgb1ORXIoFwMW8eDw0TIHjsKnyQ2c',
        //   width: width,
        //   height: height,
        // ),
    );
  }
}