class Restaurant {
  double lat, lon;
  num rating;
  String address, id, icon, name, googleMapsLink, photoLink;
  bool open_now;
  int price_level;

  Restaurant.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.lat =  json['geometry']['location']['lat'];
    this.lon = json['geometry']['location']['lng'];
    this.rating = json['rating'];
    this.address = json['vicinity'];
    this.id = json['id'];
    this.icon = json['icon'];
    this.googleMapsLink = json['photos'][0]['html_attributions'][0].substring(json['photos'][0]['html_attributions'][0].indexOf("\"") + 1, json['photos'][0]['html_attributions'][0].lastIndexOf("\""));
    this.photoLink = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${json['photos'][0]['photo_reference']}&key=AIzaSyA7C9zgb1ORXIoFwMW8eDw0TIHjsKnyQ2c';
    this.open_now = json['opening_hours']['open_now'];
    //this.price_level = json['price_level'];
  }
}