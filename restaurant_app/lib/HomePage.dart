import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restaurant_app/DeviceLocation.dart';

class HomePage extends StatefulWidget {
  _HomePageState hP = new _HomePageState();
  @override
  _HomePageState createState() => hP;
}

class _HomePageState extends State<HomePage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  DeviceLocation _location = DeviceLocation();

  double get lat => _location.lat;
  double get lon => _location.lon;

  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  void initState() {
    super.initState();

    _location.initPlatformState();

    /// Tries to sign in before even clicking the Sign in button
    _googleSignIn.signInSilently();
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
        body: Center(
            child: RaisedButton(
                child: Text(
                  "Sign In with Google",
                  style: new TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  handleSignIn();
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
                      child: new AlertDialog(
                        title: new Text("Sign In Successful"),
                        content: new Text("You have successfully signed in!"),
                        actions: [
                          new FlatButton(
                              child: new Text("Ok",
                                  style: new TextStyle(
                                    color: Colors.white,
                                  )),
                              onPressed: () => Navigator.pushReplacementNamed(
                                  context, "/results")),
                        ],
                      ),
                    );
                  }
                })));
  }
}
