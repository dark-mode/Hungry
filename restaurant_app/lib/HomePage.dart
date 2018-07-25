import 'package:flutter/material.dart';
import 'package:restaurant_app/DeviceLocation.dart';
import 'package:restaurant_app/SignIn.dart';
import 'package:restaurant_app/CuisinePage.dart';

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
    _signIn.googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('First Screen'),
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
                        style: new TextStyle(color: Colors.white),
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
                                          color: Colors.white,
                                        )),
                                    onPressed: () => Navigator.pop(context)),
                              ],
                            ),
                          );
                          _location.initPlatformState();
                        } else {
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
                                          color: Colors.white,
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
                    style: new TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    showDialog(
                      context: context,
                      child: MyDialogContent(),
                    );
                  }),
            ])));
  }
}

class MyDialogContent extends StatefulWidget {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);
  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<MyDialogContent> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  Color _walkColor = Colors.white;
  Color _driveColor = Colors.white;
  double _priceLevel = 1.0;
  var _prices = ['\$', '\$\$', '\$\$\$', '\$\$\$\$'];

  void _toggleColor(String indicator) {
    setState(() {
      if (indicator == 'Walk') {
        _walkColor = Colors.black;
        _driveColor = Colors.white;
      } else if (indicator == 'Drive') {
        _walkColor = Colors.white;
        _driveColor = Colors.black;
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
          padding: EdgeInsets.fromLTRB(70.0, 0.0, 70.0, 0.0),
          child: Text('Search Settings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 10.0),
            child: Text('What is your transportation?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
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
            child: Text('Price Range',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                )),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CuisinePage()),
                    );
                  }),
              new FlatButton(
                  child: new Text("SEARCH",
                      style: new TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () => Navigator.pop(context)),
            ],
          ))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}
