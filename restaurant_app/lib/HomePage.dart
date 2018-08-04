import 'package:flutter/material.dart';
import 'package:restaurant_app/DeviceLocation.dart';
import 'package:restaurant_app/SignIn.dart';
import 'package:restaurant_app/MaterialSearch.dart';
import 'package:restaurant_app/MyCustomRoute.dart';
import 'package:restaurant_app/UserPreferences/User.dart';
import 'package:restaurant_app/RestaurantCardViewer//ResultsPage.dart';

class HomePage extends StatefulWidget {
  _HomePageState hP = new _HomePageState();
  @override
  _HomePageState createState() => hP;
}

class _HomePageState extends State<HomePage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  DeviceLocation _location = DeviceLocation();
  SignIn _signIn = SignIn();

  double get lat => _location.lat;
  double get lon => _location.lon;

  @override
  void initState() {
    super.initState();

    _location.initPlatformState();

    /// Tries to sign in before even clicking the Sign in button
    try {
      _signIn.googleSignIn.signInSilently();
    } catch (e) {
      print('Sign In Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            'First Screen',
            style: TextStyle(fontFamily: 'RobotoCondensed'),
          ),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: RaisedButton(
                      child: Text(
                        "Sign In with Google",
                        style: new TextStyle(
                            color: Theme.of(context).textSelectionColor),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        _signIn.handleSignIn();
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
                                          color: Theme
                                              .of(context)
                                              .textSelectionColor,
                                        )),
                                    onPressed: () => Navigator.pop(context)),
                              ],
                            ),
                          );
                          _location.initPlatformState();
                        } else if (_signIn.isSignedIn) {
                          showDialog(
                            context: context,
                            child: AlertDialog(
                              title: new Text("Sign In Successful"),
                              content:
                                  new Text("You have successfully signed in!"),
                              actions: [
                                new FlatButton(
                                    child: new Text("Ok",
                                        style: new TextStyle(
                                          color: Theme
                                              .of(context)
                                              .textSelectionColor,
                                        )),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushReplacementNamed(
                                          context, "/results");
                                    }),
                              ],
                            ),
                          );
                        }
                      })),
              RaisedButton(
                  child: Text(
                    "GO",
                    style: new TextStyle(
                        color: Theme.of(context).textSelectionColor),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    showDialog(
                      context: context,
                      child: MyDialogContent(lat, lon),
                    );
                  }),
            ])));
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
    return SimpleDialog(
        title: Padding(
          padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
          child: Text(
            'SEARCH SETTINGS',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontFamily: 'RobotoCondensed'),
          ),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 10.0),
            child: Text(
              'transportation',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Eczar'),
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: new IconButton(
                      color: _walkColor,
                      icon: new Icon(Icons.directions_walk),
                      tooltip: 'Walking',
                      onPressed: () => _toggleColor('Walk'))),
              new Expanded(
                  child: new IconButton(
                      color: _driveColor,
                      icon: new Icon(Icons.directions_car),
                      tooltip: 'Driving',
                      onPressed: () => _toggleColor('Drive')))
            ],
          ),
          new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
            child: Text('price',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 15.0, fontFamily: 'Eczar')),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
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
                                    padding: const EdgeInsets.all(20.0),
                                    child: new Text(
                                        'Please pick a mode of transportation and price range.',
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0))));
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
                  child: new Text("SEARCH",
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
                                    padding: const EdgeInsets.all(20.0),
                                    child: new Text(
                                        'Please pick a mode of transportation and price range.',
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0))));
                          });
                    } else {
                      Navigator.pop(context);
                      print(_transportation);
                      print(_priceLevel);
                      User _user = User(_priceLevel.toInt(), _transportation);
                      Navigator.pushReplacement(
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
