import 'package:flutter/material.dart';

/// Creates one restaurant card
class MaterialSearchResultsItem extends Column {
  Set<String> _selectedCuisines;
  MaterialSearchResultsItem(
      String cuisine, double scaleFactor, BuildContext context, this._selectedCuisines) :
              super(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    dense: true,
                    onTap: () => _selectedCuisines.add(cuisine),
                    onLongPress: () => print(cuisine),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0.0 * scaleFactor,
                    horizontal: 40.0 * scaleFactor),
                title: new Text(cuisine,
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 45.0 * scaleFactor,
                    )),
                ),
                ],
              );
}

