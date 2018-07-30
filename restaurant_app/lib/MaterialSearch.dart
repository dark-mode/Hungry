import 'package:flutter/material.dart';

class MaterialSearch extends StatefulWidget {
  _MaterialSearchState hP = new _MaterialSearchState();
  @override
  _MaterialSearchState createState() => hP;
}

class _MaterialSearchState extends State<MaterialSearch> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Basic List",
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            title: TextField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,

              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.search),
                tooltip: 'Search',
              ),
            ]
        ),
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.all(15.0),
              sliver: new SliverList(
                delegate: new SliverChildListDelegate(
                  <Widget>[
                    const Text('I\'m dedicating every day to you'),
                    const Text('Domestic life was never quite my style'),
                    const Text('When you smile, you knock me out, I fall apart'),
                    const Text('And I thought I was so smart'),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
