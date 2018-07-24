import 'dart:async';

import 'package:flutter/material.dart';

//Holds all of the Restaurant Card Info in a page.
class CuisinePage extends StatefulWidget {
  _CuisinePageState _hP = new _CuisinePageState();
  @override
  _CuisinePageState createState() => _hP;
}

class _CuisinePageState extends State<CuisinePage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuisine Page'),
      ),
      body: Text('body')
    );
  }
}
