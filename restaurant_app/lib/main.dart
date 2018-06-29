import 'package:flutter/material.dart';
import 'package:restaurant_app/HomePage.dart';
import 'package:restaurant_app/ResultsPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomePage homeP = new HomePage();
    return new MaterialApp(
      title: "Restaurant",
      home: homeP,
      routes: {
        "/results": (_) => new ResultsPage(homeP.lon, homeP.lat),
      }
    );
  }
}