import 'package:flutter/material.dart';
import 'package:restaurant_app/MaterialSearch.dart';
import 'package:restaurant_app/MyCustomRoute.dart';
import 'package:restaurant_app/UserPreferences/User.dart';

class CuisinePage extends StatefulWidget {
  _CuisinePageState hP;
  @override
  _CuisinePageState createState() => hP;

  CuisinePage(double lat, double lon) {
    hP = new _CuisinePageState(lat, lon, null);
  }

  CuisinePage.withUser(double lat, double lon, User user) {
    hP = new _CuisinePageState(lat, lon, user);
  }
}

class _CuisinePageState extends State<CuisinePage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  double _lat, _lon;
  User _user;
  _CuisinePageState(this._lat, this._lon, this._user);

  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(title),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.search),
                tooltip: 'Search',
                onPressed: () => Navigator.push(context,
                  new MyCustomRoute(builder: (context) => MaterialSearch(_lat, _lon)),
                )
              ),]
              ),
        body: Container(child: Text('df'))
      ),
    );
  }
}