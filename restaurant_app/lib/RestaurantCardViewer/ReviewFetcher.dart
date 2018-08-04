import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';

class ReviewFetcher {
  fetchReviews(Set<Restaurant> rest) async {
    var url;
    var response;

    Map<String, dynamic> result;
    for (Restaurant r in rest) {
      url = "https://api.yelp.com/v3/businesses/${r.id}/reviews";
      response = await http.get(
        url,
        headers: {HttpHeaders.AUTHORIZATION: "Bearer c8eYj3EGPOlR3xcHsDrcdvSI17QkI4NXtUPLuux006pN-MLKggrzpFyG42T2Y40geFAJn8shKLtYEg5GcRmlO6nAHhZ-rLpV1UqQv87T53-NNDIerPM2bOPSiz9FW3Yx"},
      );
      result = json.decode(response.body.toString());
      print(response.statusCode);
      for (Map review in result['reviews'])
        r.reviews.add(review);
    }
  }
}
