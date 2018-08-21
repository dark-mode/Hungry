import 'package:flutter/material.dart';
import 'package:restaurant_app/MaterialSearchResultsItem.dart';
//adapted from https://hackernoon.com/flutter-iii-lists-and-items-6bfa7348ab1b

class MaterialSearchResults extends StatelessWidget {
  List<String> _cuisines;
  Set<String> _selectedCuisines;
  State _state;

  MaterialSearchResults(this._cuisines, this._selectedCuisines, this._state);

  /// Displays list of restaurant cards
  @override
  Widget build(BuildContext context) {
    double scaleFactor = MediaQuery.of(context).textScaleFactor / 3;
    return new ListView(
        padding: new EdgeInsets.symmetric(vertical: 20.0 * scaleFactor),
        children: _buildCuisineList(scaleFactor, context));
  }

  /// Creates a list of cards to be viewed on the Results Page
  List<MaterialSearchResultsItem> _buildCuisineList(
      double scaleFactor, BuildContext context) {
    List<MaterialSearchResultsItem> items = [];
    Icon _checkmark;
    for (String _cuisine in _cuisines) {
      _checkmark = null;
      if (this._selectedCuisines.contains(_cuisine)) {
        print(_cuisine + " was selected");
          _checkmark = new Icon(Icons.check, color: Colors.teal[400]);
      }
      items.add(MaterialSearchResultsItem(_cuisine, scaleFactor, context, _selectedCuisines, _checkmark, _state));
    }
    return items;
  }
}
