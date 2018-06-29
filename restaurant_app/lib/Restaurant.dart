class Restaurant {
  double lat, lon, rating;
  String address, id, icon, name, maps_photo_link;
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

    //this.open_now = json['opening_hours']['open_now'];
    //this.price_level = json['price_level'];
  }
}