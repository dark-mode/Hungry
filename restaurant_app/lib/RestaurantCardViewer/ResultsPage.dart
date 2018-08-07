import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';
import 'package:restaurant_app/RestaurantCardViewer//RestaurantFetcher.dart';
import 'package:restaurant_app/RestaurantCardViewer//ReviewFetcher.dart';
import 'package:restaurant_app/RestaurantCardInfo/RestaurantList.dart';
import 'package:restaurant_app/UserPreferences/Recommender.dart';
import 'package:restaurant_app/UserPreferences/User.dart';

//Holds all of the Restaurant Card Info in a page.
class ResultsPage extends StatefulWidget {
  _ResultsPageState _hP;
  @override
  _ResultsPageState createState() => _hP;

  double _lat, _lon;
  User _user;
  ResultsPage(double lat, double lon) {
    _lat = lat;
    _lon = lon;
    _hP = new _ResultsPageState(lat, lon, Set(), null);
  }

  ResultsPage.withUser(double lat, double lon, User user) {
    _lat = lat;
    _lon = lon;
    _user = user;
    _hP = new _ResultsPageState(lat, lon, Set(), _user);
  }

  ResultsPage.cuisines(double lat, double lon, Set<String> _selectedCuisines, User user) {
    _lat = lat;
    _lon = lon;
    _user = user;
    _hP = new _ResultsPageState(lat, lon, _selectedCuisines, _user);
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
  List<Restaurant> restaurants;
  Future<Set<Restaurant>> rFuture;
  bool notFound = false;
  User _user;

  _ResultsPageState(this._lat, this._lon, this._selectedCuisines, this._user);

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    RestaurantFetcher rF = new RestaurantFetcher(_lat, _lon, _selectedCuisines);
    Set<Restaurant> rests = await rF.fetchRestaurants();
    Recommender rec = Recommender(_user, rests);
    List<Restaurant> r = rec.runAlgorithm();
    setState(() => restaurants = r);

    ReviewFetcher revF = ReviewFetcher();
    for (Restaurant rest in restaurants) {
      await revF.fetchReview(rest);
      setState(() => restaurants = r);
    }

    if (rests == null) notFound = true;
  }

  @override
  Widget build(BuildContext context) {
    var child;
    double scaleFactor =
        MediaQuery.of(context).textScaleFactor / 2.5; //change later

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
                  color: Theme.of(context).primaryColor,
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
      child = RestaurantList(restaurants.toList(), _selectedCuisines);
    } else {
      child = Container(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
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
                        height: 125.0 * scaleFactor,
                        width: 125.0 * scaleFactor,
                        child: new CircularProgressIndicator(
                          value: null,
                          strokeWidth: 15.0 * scaleFactor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25.0 * scaleFactor),
                      child: Center(
                        child: Text(
                          "Loading...",
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 50.0 * scaleFactor
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
        title: Text(
            'Your Top Picks',
            style: TextStyle(
              fontSize: 75.0 * scaleFactor,
              fontFamily: 'Eczar'
            )
        ),
      ),
        body:Center(
          child: child,
        ),
//      body: new Container(child: child),
    );
  }
}
