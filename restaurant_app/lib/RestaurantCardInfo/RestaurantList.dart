import 'package:flutter/material.dart';
import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';
import 'package:restaurant_app/RestaurantCardInfo/RestaurantListItem.dart';
import 'package:flutter/rendering.dart';
//adapted from https://hackernoon.com/flutter-iii-lists-and-items-6bfa7348ab1b

class RestaurantList extends StatefulWidget {
  _RestaurantListState _rP;
  @override
  _RestaurantListState createState() => _rP;

  final List<Restaurant> _restaurants;
  Set<String> _selectedCuisines;
  bool _allTags;

  RestaurantList(this._restaurants, this._selectedCuisines, this._allTags) {
    _rP = _RestaurantListState(this._restaurants, this._selectedCuisines, this._allTags);
  }

  bool get isVisible => _rP._isVisible;
}


class _RestaurantListState extends State<RestaurantList> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  final List<Restaurant> _restaurants;
  Set<String> _selectedCuisines;
  bool _allTags;
  ScrollController _hideButtonController;
  bool _isVisible = true;
  bool get isVisible => _isVisible;

  _RestaurantListState(this._restaurants, this._selectedCuisines,
      this._allTags);


  @override
  void initState() {
    super.initState();
    initPlatformState();

//    _isVisible = true;
//    _hideButtonController = new ScrollController();
//    _hideButtonController.addListener((){
//      if(_hideButtonController.position.userScrollDirection == ScrollDirection.reverse) {
//        setState(() {
//          _isVisible = true;
//        });
//      }
//
//      if(_hideButtonController.position.userScrollDirection == ScrollDirection.forward){
//        setState((){
//          _isVisible = false;
//        });
//      }
//    });
  }

  initPlatformState() async {
  }


  /// Creates a list of cards to be viewed on the Results Page
  List<RestaurantListItem> _buildRestaurantList(double scaleFactor,
      BuildContext context) {
    return _restaurants
        .map((restaurant) =>
    new RestaurantListItem(
        restaurant, scaleFactor, _selectedCuisines, _allTags, context))
        .toList();
  }

  /// Displays list of restaurant cards
  @override
  Widget build(BuildContext context) {
    double scaleFactor = MediaQuery
        .of(context)
        .textScaleFactor / 2.8;
    return new ListView(
        //controller: _hideButtonController,
        padding: new EdgeInsets.symmetric(vertical: 20.0 * scaleFactor),
        children: _buildRestaurantList(scaleFactor, context));
  }
}
