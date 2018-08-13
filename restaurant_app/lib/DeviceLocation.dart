import 'dart:async';

import 'package:flutter/services.dart';
//import 'package:location/location.dart';
import 'package:geolocation/geolocation.dart';

class DeviceLocation {
  //Location _location = Location();
  double _lat, _lon;
  String value, error;
  var restaurants = Set();

  double get lat => _lat;
  double get lon => _lon;

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    //Map<String, double> location;
    GeolocationResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    result = await Geolocation.requestLocationPermission(const LocationPermission(
      android: LocationPermissionAndroid.fine,
      ios: LocationPermissionIOS.always,
    ));
    StreamSubscription<LocationResult> subscription = Geolocation.currentLocation(accuracy: LocationAccuracy.best).listen((result) {
      if(result.isSuccessful) {
        _lat = result.location.latitude;
        _lon = result.location.longitude;
        // todo with result
      }
    });
  }
}
