import 'package:flutter/material.dart';

class RestaurantPage extends StatefulWidget {
  _RestaurantPageState hP = new _RestaurantPageState();
  @override
  _RestaurantPageState createState() => hP;
}

class _RestaurantPageState extends State<RestaurantPage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);
  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Page'),
      ),
      body: Center(
        child: Text("This is the Restaurant Page."),
      ),
    );
  }
}