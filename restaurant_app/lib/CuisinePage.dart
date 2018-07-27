import 'package:flutter/material.dart';

class CuisinePage extends StatefulWidget {
  _CuisinePageState hP = new _CuisinePageState();
  @override
  _CuisinePageState createState() => hP;
}

class _CuisinePageState extends State<CuisinePage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Map'),
            ),
            ListTile(
              title: Text('Album'),
            ),
            ListTile(
              title: Text('Phone'),
            ),
          ],
        ),
      ),
    );
  }
}