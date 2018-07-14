import 'package:location/location.dart';
import 'package:flutter/services.dart';

class DeviceLocation {
  Location _location = Location();
  double _lat, _lon;
  String value, error;
  var restaurants = Set();

  double get lat => _lat;
  double get lon => _lon;

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      location = await _location.getLocation;
      error = null;
      _lat = location['latitude'];
      _lon = location['longitude'];
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
        'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }
  }
}

