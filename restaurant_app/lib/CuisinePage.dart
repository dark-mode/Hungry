import 'package:flutter/material.dart';
import 'package:restaurant_app/CuisineList.dart';
import 'package:restaurant_app/MaterialSearch.dart';
import 'package:restaurant_app/MyCustomRoute.dart';

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
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(title),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.search),
                tooltip: 'Search',
                onPressed: () => Navigator.push(context,
                  new MyCustomRoute(builder: (context) => new MaterialSearch()),
                )
              ),]
              ),
        body: Container(child: Text('df'))
      ),
    );
  }
}