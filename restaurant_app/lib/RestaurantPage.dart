import 'package:flutter/material.dart';
import 'package:restaurant_app/Restaurant.dart';
import 'package:url_launcher/url_launcher.dart';

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

  _launchURL(link) async {
  String url = link;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    Column buildButtonColumn(IconData icon, String label) {
      Color color = Colors.white;

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          new GestureDetector(
          onTap: (){
            _launchURL(restaurant.googleMapsLink);
          }, child: Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(
                label,
                style: TextStyle(
                 fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ),
        ],
      );
    }

    Widget buttonSection = Container(
      padding: const EdgeInsets.only(top: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );

  Widget textSection = Container(
    padding: const EdgeInsets.all(32.0),
    child: Text(restaurant.id),
      );

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: ListView(
          children: [
            Image.network(
              restaurant.photoLink,
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,
            ),
            buttonSection,
            textSection,
          ],
      )
    );
  }
}



