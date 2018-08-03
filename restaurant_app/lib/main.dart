import 'package:flutter/material.dart';
import 'package:restaurant_app/HomePage.dart';
import 'package:restaurant_app/RestaurantCardViewer/ResultsPage.dart';
import 'package:restaurant_app/CuisinePage.dart';
import 'package:restaurant_app/MaterialSearch.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomePage homeP = new HomePage();
    return new MaterialApp(
        title: "Restaurant",
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.teal[400],
            accentColor: Colors.grey[900]),
        home: homeP,
        routes: {
          "/results": (_) => new ResultsPage(homeP.hP.lat, homeP.hP.lon),
          "/cuisines": (_) => new CuisinePage(homeP.hP.lat, homeP.hP.lon),
          "/materialsearch": (_) => new MaterialSearch(homeP.hP.lat, homeP.hP.lon),
        });
  }
}
