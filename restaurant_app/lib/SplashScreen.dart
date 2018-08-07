import 'dart:async';

import 'package:flutter/material.dart';

//@src https://medium.com/@vigneshprakash15/flutter-splash-screen-84fb0307ac55

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: CircleAvatar(backgroundImage: NetworkImage('https://scontent-sjc3-1.xx.fbcdn.net/v/t1.0-9/11110274_650575965074197_4809913181131680717_n.jpg?_nc_cat=0&oh=a03d48d4b1a4a6f47632f98aab238794&oe=5C08DA03'), radius: 100.0,),
      ),
    );
  }
}