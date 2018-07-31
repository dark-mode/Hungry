import 'package:flutter/material.dart';
import 'package:restaurant_app/CuisineList.dart';

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
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.search),
                tooltip: 'Search',
                onPressed: () => Navigator.pushReplacementNamed(context, "/materialsearch")
              ),]
              ),
        body: Container(child: Text('df'))
      ),
    );
  }
}