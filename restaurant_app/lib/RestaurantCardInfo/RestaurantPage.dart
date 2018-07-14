import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';
import 'package:url_launcher/url_launcher.dart';

Restaurant restaurant;

/// GOOGLE API KEY
String key = 'AIzaSyA7C9zgb1ORXIoFwMW8eDw0TIHjsKnyQ2c';

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
    Restaurant rest = await fetchPlaceDetails();
  }

  //@src https://pub.dartlang.org/packages/url_launcher#-readme-tab-
  _launchURL(link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Gets individual restaurant data
  fetchPlaceDetails() async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?placeid=${restaurant.placeID}&fields=opening_hours,website,formatted_phone_number&key=${key}";
    final response = await http.get(url);
    Map<String, dynamic> result = json.decode(response.body.toString());
    restaurant.setPlaceDetails(
        result['result']['opening_hours']['weekday_text'],
        result['result']['formatted_phone_number'],
        result['result']['website']);
  }

  //@src https://flutter.io/tutorials/layout/
  @override
  Widget build(BuildContext context) {
    GestureDetector buildButtonColumn(IconData icon, String label) {
      Color color = Colors.white;

      return GestureDetector(
          onTap: () {
            if (label == 'CALL') {
              if (restaurant.phoneNumber == null) {
                showDialog(
                  context: context,
                  child: new AlertDialog(
                    title: new Text("No Phone Number"),
                    content: new Text("This restaurant has no phone number."),
                    actions: [
                      new FlatButton(
                          child: new Text("Ok",
                              style: new TextStyle(
                                color: Colors.white,
                              )),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                );
              } else
                launch("tel://${restaurant.phoneNumber}");
            } else if (label == 'ROUTE') {
              _launchURL(
                  'https://www.google.com/maps/search/?api=1&query=${restaurant.address}');
            } else if (label == 'WEBSITE') {
              if (restaurant.website == null) {
                showDialog(
                  context: context,
                  child: new AlertDialog(
                    title: new Text("No Website"),
                    content: new Text("This restaurant has no website."),
                    actions: [
                      new FlatButton(
                          child: new Text("Ok",
                              style: new TextStyle(
                                color: Colors.white,
                              )),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                );
              } else
                _launchURL(restaurant.website);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: Icon(icon, color: color),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ],
          ));
    }

    Widget buttonSection = Container(
      padding: const EdgeInsets.only(top: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.language, 'WEBSITE'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Text(restaurant.id),
    );

    double width = MediaQuery.of(context).size.width;
    double height = (MediaQuery.of(context).size.height / 4);
    return Scaffold(
        appBar: AppBar(
          title: Text(restaurant.name),
        ),
        body: ListView(
          children: [
            new Container(
              width: width,
              height: height,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(20.0),
                color: const Color(0xff7c94b6),
                image: new DecorationImage(
                  image: new NetworkImage(
                      "https://maps.googleapis.com/maps/api/place/photo?maxwidth=${width.round()}&photoreference=${restaurant.photoReference}&key=${key}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            buttonSection,
            textSection,
          ],
        ));
  }
}
