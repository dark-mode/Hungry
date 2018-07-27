import 'package:flutter/material.dart';

/// Creates one restaurant card
class CuisineListItem extends Card {
  CuisineListItem(
      String cuisine, double scaleFactor, BuildContext context)
      : super(
    margin: EdgeInsets.only(
        top: 20.0 * scaleFactor,
        bottom: 20.0 * scaleFactor,
        left: 25.0 * scaleFactor,
        right: 25.0 * scaleFactor),
    child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.symmetric(
              vertical: 55.0 * scaleFactor,
              horizontal: 60.0 * scaleFactor),
          leading: const Icon(Icons.album),
          title: new Text(cuisine,
              textAlign: TextAlign.left,
              style: new TextStyle(
                color: Colors.black,
                fontSize: 65.0 * scaleFactor,
              )),
        ),
      ],
    ),
  );
}
