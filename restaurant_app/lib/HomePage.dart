import 'package:flutter/material.dart';
import 'package:restaurant_app/DeviceLocation.dart';
import 'package:restaurant_app/SignIn.dart';

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
                        content: new Text("You have successfully signed in!"),
                        actions: [
                              new FlatButton(
                                  child: new Text(
                                          "Ok",
                                          style: new TextStyle(
                                            color: Colors.white,
                                          )
                                    ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushReplacementNamed(context, "/results");
                                  }
                          ),
                        ],
                      ),
                    );
                  }
                })
                ),
              RaisedButton(
                child: Text(
                  "GO",
                  style: new TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  showDialog(
                    context: context,
                    child: new SimpleDialog(
                        title: const Text('What is your transportation?'),
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Expanded(
                                  child:
                                  new IconButton(
                                    icon: new Icon(Icons.person),
                                    tooltip: 'Walking',
                                    onPressed: () { },
                                  )
                              ),
                              new Expanded(
                                  child:
                                  new IconButton(
                                    icon: new Icon(Icons.directions_bus),
                                    tooltip: 'Driving',
                                    onPressed: () { },
                                  ))
                            ],
                          )
                        ]
                    ),
                  );
                }
              ),
            ])
    ));
  }
}
