import 'package:flutter/material.dart';

/// Creates one restaurant card
class MaterialSearchResultsItem extends Column {
  Set<String> _selectedCuisines;
  Icon _checkmark;
  State _state;
  MaterialSearchResultsItem(
      String cuisine, double scaleFactor, BuildContext context, this._selectedCuisines, this._checkmark, this._state) :
              super(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent
                    ),
                    child: ListTile(
                        trailing: _checkmark,
                        dense: true,
                        onTap: () {
                          if (_selectedCuisines.contains(cuisine)) {
                            _selectedCuisines.remove(cuisine);
                          } else {
                            _selectedCuisines.add(cuisine);
                          }
                          bool dead;
                          _state.setState(() => dead = true);
                        },
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
                    )
                  ),
                ],
              );
}

