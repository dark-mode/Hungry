import 'package:flutter/material.dart';
import 'package:restaurant_app/MaterialSearchResultsItem.dart';
//adapted from https://hackernoon.com/flutter-iii-lists-and-items-6bfa7348ab1b

class MaterialSearchResults extends StatelessWidget {
  final List<String> _cuisines;

  MaterialSearchResults(this._cuisines);

  /// Displays list of restaurant cards
  @override
  Widget build(BuildContext context) {
    double scaleFactor = 1 / MediaQuery.of(context).devicePixelRatio;
    return new ListView(
        padding: new EdgeInsets.symmetric(vertical: 20.0 * scaleFactor),
        children: _buildCuisineList(scaleFactor, context));
  }

  /// Creates a list of cards to be viewed on the Results Page
  List<MaterialSearchResultsItem> _buildCuisineList(
      double scaleFactor, BuildContext context) {
    return _cuisines
        .map((cuisine) =>
    MaterialSearchResultsItem(cuisine, scaleFactor, context)).toList();
  }
}
