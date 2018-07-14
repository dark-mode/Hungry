import 'package:flutter/material.dart';
import 'package:restaurant_app/HomePage.dart';
import 'package:restaurant_app/RestaurantCardViewer/ResultsPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomePage homeP = new HomePage();
    return new MaterialApp(
        title: "Restaurant",
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black,
            accentColor: Colors.black),
        home: homeP,
        routes: {
          "/results": (_) => new ResultsPage(homeP.hP.lat, homeP.hP.lon),
        });
  }
}
