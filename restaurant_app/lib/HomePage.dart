import 'package:flutter/material.dart';
import 'package:restaurant_app/DeviceLocation.dart';
import 'package:restaurant_app/SignIn.dart';
import 'package:restaurant_app/MaterialSearch.dart';
import 'package:restaurant_app/MyCustomRoute.dart';
import 'package:restaurant_app/UserPreferences/User.dart';
import 'package:restaurant_app/RestaurantCardViewer//ResultsPage.dart';
import 'package:restaurant_app/RestaurantCardViewer//RestaurantFetcher.dart';
import 'package:restaurant_app/RestaurantCardInfo/RestaurantList.dart';
import 'package:restaurant_app/RestaurantCardViewer//ReviewFetcher.dart';
import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';
import 'package:restaurant_app/UserPreferences/Recommender.dart';

class HomePage extends StatefulWidget {
  _HomePageState hP = new _HomePageState();
  @override
  _HomePageState createState() => hP;
}

class _HomePageState extends State<HomePage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  DeviceLocation _location = DeviceLocation();
//  SignIn _signIn = SignIn();

  double get lat => _location.lat;
  double get lon => _location.lon;
  List<Restaurant> restaurants;
  User _user;
  bool notFound = false;

  @override
  void initState() {
    super.initState();

    initPlatformState();

    /// Tries to sign in before even clicking the Sign in button
//    try {
//      _signIn.googleSignIn.signInSilently();
//    } catch (e) {
//      print('Sign In Error');
//    }
  }

  initPlatformState() async {
    await _location.initPlatformState();
    if (lat != null && lon != null) {
      RestaurantFetcher rF = new RestaurantFetcher(lat, lon, Set<String>());
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
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    if (restaurants == null) initPlatformState();
    var child;
    double scaleFactor =
        MediaQuery.of(context).textScaleFactor / 2.5; //change later

    if (notFound)
      child = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(40.0 * scaleFactor),
            child: Text('No Results',
                style: TextStyle(fontSize: 40.0 * scaleFactor)),
          ),
          Container(
              child: RaisedButton(
            color: Theme.of(context).primaryColor,
            child:
                Text('Go Back', style: TextStyle(fontSize: 40.0 * scaleFactor)),
            onPressed: () => Navigator.pop(context),
          ))
        ],
      );
    else if (restaurants != null && restaurants.length != 0) {
      child = RestaurantList(restaurants.toList(), Set<String>());
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
                    borderRadius: BorderRadius.circular(10.0 * scaleFactor)),
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
                              fontSize: 50.0 * scaleFactor),
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
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Row(children: <Widget>[
            Text(
              'Places Near You',
              style: TextStyle(fontFamily: 'RobotoCondensed'),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "GO",
          backgroundColor: Theme.of(context).primaryColor,
          mini: false,
          child: Icon(Icons.arrow_forward ,color: Colors.white,),
          onPressed: () {
            if (_location.lat == null || _location.lon == null) {
              showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text("Location Needed"),
                  content: new Text(
                      "Location is disabled on this device. Please enable it and try again. If you have already enabled location, try restarting the app."),
                  actions: [
                    new FlatButton(
                        child: new Text("Ok",
                            style: new TextStyle(
                              color: Theme.of(context).textSelectionColor,
                            )),
                        onPressed: () {
                          Navigator.pop(context);
                          initPlatformState();
                        })
                  ],
                ),
              );
            } else {
              showDialog(
                context: context,
                child: MyDialogContent(lat, lon),
              );
            }
          },
        ),
        body: Center(child: child
//              child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Container(
//                        padding: const EdgeInsets.only(bottom: 8.0),
//                        child: RaisedButton(
//                            child: Text(
//                              "Sign In with Google",
//                              style: new TextStyle(
//                                  color: Theme
//                                      .of(context)
//                                      .textSelectionColor),
//                            ),
//                            color: Theme
//                                .of(context)
//                                .primaryColor,
//                            onPressed: () {
//                              //_signIn.handleSignIn();
//                              if (_location.lat == null ||
//                                  _location.lon == null) {
//                                showDialog(
//                                  context: context,
//                                  child: new AlertDialog(
//                                    title: new Text("Location Needed"),
//                                    content: new Text(
//                                        "Location is disabled on this device. Please enable it and try again. If you have already enabled location, try restarting the app."),
//                                    actions: [
//                                      new FlatButton(
//                                          child: new Text("Ok",
//                                              style: new TextStyle(
//                                                color: Theme
//                                                    .of(context)
//                                                    .textSelectionColor,
//                                              )),
//                                          onPressed: () {
//                                            Navigator.pop(context);
//                                            _location.initPlatformState();
//                                          })
//                                    ],
//                                  ),
//                                );
//                              } //else if (_signIn.isSignedIn) {
//                              else {
//                                showDialog(
//                                  context: context,
//                                  child: AlertDialog(
//                                    title: new Text("Sign In Successful"),
//                                    content:
//                                    new Text(
//                                        "You have successfully signed in!"),
//                                    actions: [
//                                      new FlatButton(
//                                          child: new Text("Ok",
//                                              style: new TextStyle(
//                                                color: Theme
//                                                    .of(context)
//                                                    .textSelectionColor,
//                                              )),
//                                          onPressed: () {
//                                            Navigator.pop(context);
//                                            Navigator.pushReplacementNamed(
//                                                context, "/results");
//                                          }),
//                                    ],
//                                  ),
//                                );
//                              }
//                            })),
//                    RaisedButton(
//                        child: Text(
//                          "GO",
//                          style: new TextStyle(
//                              color: Theme
//                                  .of(context)
//                                  .textSelectionColor),
//                        ),
//                        color: Theme
//                            .of(context)
//                            .primaryColor,
//                        onPressed: () {
//                          if (_location.lat == null || _location.lon == null) {
//                            showDialog(
//                              context: context,
//                              child: new AlertDialog(
//                                title: new Text("Location Needed"),
//                                content: new Text(
//                                    "Location is disabled on this device. Please enable it and try again. If you have already enabled location, try restarting the app."),
//                                actions: [
//                                  new FlatButton(
//                                      child: new Text("Ok",
//                                          style: new TextStyle(
//                                            color: Theme
//                                                .of(context)
//                                                .textSelectionColor,
//                                          )),
//                                      onPressed: () => Navigator.pop(context)),
//                                ],
//                              ),
//                            );
//                            initPlatformState();
//                          } else {
//                            showDialog(
//                              context: context,
//                              child: MyDialogContent(lat, lon),
//                            );
//                          }
//                        }),
//                  ]))
            ));
  }
}

class MyDialogContent extends StatefulWidget {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);
  double _lat, _lon;
  MyDialogContent(this._lat, this._lon);

  @override
  _MyDialogContentState createState() => new _MyDialogContentState(_lat, _lon);
}

class _MyDialogContentState extends State<MyDialogContent> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  double _lat, _lon;

  _MyDialogContentState(this._lat, this._lon);
  Color _walkColor = Colors.teal[700];
  Color _driveColor = Colors.teal[700];
  double _priceLevel = 1.0;
  String _transportation;
  var _prices = ['\$', '\$\$', '\$\$\$', '\$\$\$\$'];

  void _toggleColor(String indicator) {
    _transportation = indicator;
    setState(() {
      if (indicator == 'Walk') {
        _walkColor = Theme.of(context).primaryColorLight;
        _driveColor = Theme.of(context).primaryColorDark;
      } else if (indicator == 'Drive') {
        _walkColor = Theme.of(context).primaryColorDark;
        _driveColor = Theme.of(context).primaryColorLight;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  _getContent() {
    double scaleFactor =
        MediaQuery.of(context).textScaleFactor / 2.5; //change later

    return SimpleDialog(
        title: Padding(
          padding: EdgeInsets.fromLTRB(
              40.0 * scaleFactor, 0.0, 40.0 * scaleFactor, 0.0),
          child: Text(
            'SEARCH SETTINGS',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 80.0 * scaleFactor,
                fontFamily: 'RobotoCondensed'),
          ),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(40.0 * scaleFactor, 20.0 * scaleFactor,
                40.0 * scaleFactor, 10.0 * scaleFactor),
            child: Text(
              'transportation',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 55.0 * scaleFactor,
                  fontFamily: 'Eczar'),
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: new IconButton(
                      color: _walkColor,
                      icon: new Icon(Icons.directions_walk),
                      tooltip: 'walking',
                      onPressed: () => _toggleColor('Walk'))),
              new Expanded(
                  child: new IconButton(
                      color: _driveColor,
                      icon: new Icon(Icons.directions_car),
                      tooltip: 'driving',
                      onPressed: () => _toggleColor('Drive')))
            ],
          ),
          new Padding(
            padding: EdgeInsets.fromLTRB(
                0.0 * scaleFactor, 20.0 * scaleFactor, 0.0, 10.0 * scaleFactor),
            child: Text('price',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 55.0 * scaleFactor,
                    fontFamily: 'Eczar')),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                30.0 * scaleFactor, 0.0, 30.0 * scaleFactor, 0.0),
            child: new Slider(
              value: _priceLevel,
              min: 1.0,
              max: 4.0,
              divisions: 3,
              label: _prices[_priceLevel.round() - 1],
              onChanged: (double value) {
                setState(() {
                  _priceLevel = value;
                });
              },
            ),
          ),
          new Container(
              child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new FlatButton(
                  child: new Text("OPTIONS",
                      style: new TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () {
                    if (_transportation == null) {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return new Container(
                                child: new Padding(
                                    padding: EdgeInsets.all(20.0 * scaleFactor),
                                    child: new Text(
                                        'Please pick a mode of transportation and price range.',
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 55.0 * scaleFactor))));
                          });
                    } else {
                      User _user = User(_priceLevel.toInt(), _transportation);
                      Navigator.push(
                        context,
                        new MyCustomRoute(
                            builder: (context) =>
                                MaterialSearch.withUser(_lat, _lon, _user)),
                      );
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => CuisinePage.withUser(_lat, _lon, _user)),
//                    );
                    }
                  }),
              new FlatButton(
                  child: Text("SEARCH",
                      style: new TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () {
                    if (_transportation == null) {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return new Container(
                                child: new Padding(
                                    padding: EdgeInsets.all(20.0 * scaleFactor),
                                    child: new Text(
                                        'Please pick a mode of transportation and price range.',
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0 * scaleFactor))));
                          });
                    } else {
                      Navigator.pop(context);
                      print(_transportation);
                      print(_priceLevel);
                      User _user = User(_priceLevel.toInt(), _transportation);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ResultsPage.withUser(_lat, _lon, _user)));
                    }
                  }),
            ],
          ))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}
