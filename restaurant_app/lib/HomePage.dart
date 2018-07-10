import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  _HomePageState hP = new _HomePageState();
  @override
  _HomePageState createState() => hP;
}

class _HomePageState extends State<HomePage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  Map<String, double> _startLocation;

  GoogleSignIn _googleSignIn = new GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );

  Location _location = new Location();
  double _lat, _lon;
  String value, error;
  var restaurants = new Set();

  bool currentWidget = true;

  Image image1;

  double get lat => _lat;
  double get lon => _lon;

  @override
  void initState() {
    super.initState();

    initPlatformState();
    _googleSignIn.signInSilently();

  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      location = await _location.getLocation;
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
          showDialog(context: context, 
            child:
              new AlertDialog(
                title: new Text("Location Needed"),
                content: new Text("Location is disabled on this device. Please enable it and try again. If you have already enabled location, try restarting the app."),
                actions: [
                  new FlatButton(
                    child: new Text(
                      "Ok",
                      style: new TextStyle(
                        color: Colors.white,
                      )
                    ),
                    onPressed: () => Navigator.pop(context)
                  ),
                ],
              ),
          );
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    setState(() {
        _startLocation = location;
        _lat = location['latitude'];        
        _lon = location['longitude'];
    });

  }


void handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Column(
        children: <Widget>[
           Center(
            child: RaisedButton(
              child: Text("enter"), 
              onPressed: () {
                if (_lat == null || _lon == null) {
                  showDialog(context: context, 
                  child:
                    new AlertDialog(
                      title: new Text("Location Needed"),
                      content: new Text("Location is disabled on this device. Please enable it and try again. If you have already enabled location, try restarting the app."),
                      actions: [
                        new FlatButton(
                          child: new Text(
                            "Ok",
                            style: new TextStyle(
                              color: Colors.white,
                            )
                          ),
                          onPressed: () => Navigator.pop(context)
                        ),
                      ],
                    ),
                  );
                  initPlatformState();
                }
                else {
                // Navigate to second screen when tapped!
                  Navigator.pushReplacementNamed(context, "/results");
                }
              },
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text(
                "Sign In",
                style: new TextStyle(
                  color: Colors.white
                ),
              ),              
              onPressed: handleSignIn,
            )
          )
        ])
    );
  }
}