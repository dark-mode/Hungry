import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';
import 'package:restaurant_app/RestaurantCardViewer//RestaurantFetcher.dart';
import 'package:restaurant_app/RestaurantCardInfo/RestaurantList.dart';

//Holds all of the Restaurant Card Info in a page.
class ResultsPage extends StatefulWidget {
  _ResultsPageState _hP;
  @override
  _ResultsPageState createState() => _hP;

  double _lat, _lon;
  ResultsPage(double lat, double lon) {
    _lat = lat;
    _lon = lon;
    _hP = new _ResultsPageState(lat, lon, Set());
  }

  ResultsPage.cuisines(double lat, double lon, Set<String> _selectedCuisines) {
    _lat = lat;
    _lon = lon;
    _hP = new _ResultsPageState(lat, lon, _selectedCuisines);
  }
  double get lat => _lat;
  double get lon => _lon;
}

class _ResultsPageState extends State<ResultsPage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  //var url, request, response;
  //String value, error;
  double _lat, _lon;
  Set<String> _selectedCuisines;
  Set<Restaurant> restaurants;
  Future<Set<Restaurant>> rFuture;
  bool notFound = false;

  _ResultsPageState(this._lat, this._lon, this._selectedCuisines);

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    RestaurantFetcher rF = new RestaurantFetcher(_lat, _lon, _selectedCuisines);
    Set<Restaurant> rest = await rF.fetchRestaurants();
    if (rest == null) notFound = true;
    setState(() => restaurants = rest);
  }

  @override
  Widget build(BuildContext context) {
    var child;
    double scaleFactor =
        1 / MediaQuery.of(context).devicePixelRatio; //change later

    if (notFound)
      child = Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Container(
              padding: EdgeInsets.all(40.0 * scaleFactor),
              child: Text(
                  'No Results',
                  style: TextStyle(
                    fontSize: 40.0 * scaleFactor
                  )
              ),
            ),
            Container(
                child: RaisedButton(
                        child: Text(
                            'Go Back',
                            style: TextStyle(
                              fontSize: 40.0 * scaleFactor
                            )
                        ),
                        onPressed: () => Navigator.pop(context),
                      )
            )
          ],
      );
    else if (restaurants != null && restaurants.length != 0) {
      child = RestaurantList(restaurants.toList());
    } else {
      child = Container(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0 * scaleFactor)
                ),
                width: 600.0 * scaleFactor,
                height: 400.0 * scaleFactor,
                alignment: AlignmentDirectional.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: new SizedBox(
                        height: 75.0 * scaleFactor,
                        width: 75.0 * scaleFactor,
                        child: new CircularProgressIndicator(
                          value: null,
                          strokeWidth: 15.0 * scaleFactor,
                        ),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 25.0 * scaleFactor),
                      child: Center(
                        child: Text(
                          "loading.. wait...",
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 40.0 * scaleFactor
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
        body:Center(
          child: child,
        ),
//      body: new Container(child: child),
    );
  }
}
