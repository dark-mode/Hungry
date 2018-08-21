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
//    result = await Geolocation.requestLocationPermission(const LocationPermission(
//      android: LocationPermissionAndroid.fine,
//      ios: LocationPermissionIOS.always,
//    ));

//    StreamSubscription<LocationResult> subscription = Geolocation.currentLocation(accuracy: LocationAccuracy.best).listen((result) {
//      if(result.isSuccessful) {
//        _lat = result.location.latitude;
//        _lon = result.location.longitude;
//        // todo with result
//      }
//    });
    //LocationResult result2 = await Geolocation.lastKnownLocation();
//    Geolocation.singleLocationUpdate(accuracy: LocationAccuracy.best).listen((result) {
//      if (result.isSuccessful) {
//        _lat = result.location.latitude;
//        _lon = result.location.longitude;
//      }
//    });
//    if (result2.isSuccessful) {
//      // location request successful, location is guaranteed to not be null
//      _lat = result2.location.latitude;
//      _lon = result2.location.longitude;
//    }
    StreamSubscription<LocationResult> subscription = Geolocation.locationUpdates(
      accuracy: LocationAccuracy.best,
      displacementFilter: 10.0, // in meters
      inBackground: true, // by default, location updates will pause when app is inactive (in background). Set to `true` to continue updates in background.
    )
        .listen((result) {
      if(result.isSuccessful) {
        // todo with result
        _lat = result.location.latitude;
        _lon = result.location.longitude;
      }
    });
    if (_lat != null)
      subscription.cancel();
  }
}
