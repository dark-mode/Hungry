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
        title: "Hungry",
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'RobotoCondensed',
          primaryColor: Colors.teal[400],
          primaryColorLight: Colors.teal[300],
          primaryColorDark: Colors.teal[700],
          backgroundColor: Colors.grey[850],
          accentColor: Colors.tealAccent,
          textSelectionColor: Colors.white,
        ),
        home: homeP,
        routes: {
          "/results": (_) => new ResultsPage(homeP.hP.lat, homeP.hP.lon),
          "/cuisines": (_) => new CuisinePage(homeP.hP.lat, homeP.hP.lon),
          "/materialsearch": (_) => new MaterialSearch(homeP.hP.lat, homeP.hP.lon),
        });
  }
}
