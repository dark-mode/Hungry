import 'package:flutter/material.dart';

/// Creates one restaurant card
class MaterialSearchResultsItem extends Column {
  MaterialSearchResultsItem(
      String cuisine, double scaleFactor, BuildContext context) :
              super(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    dense: true,
                    onLongPress: hi,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0.0 * scaleFactor,
                    horizontal: 40.0 * scaleFactor),
                title: new Text(cuisine,
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      fontSize: 45.0 * scaleFactor,
                    )),
                ),
                ],
              );
}
hi() {

}
