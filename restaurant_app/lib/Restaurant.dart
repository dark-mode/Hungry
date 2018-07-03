class Restaurant {
  double lat, lon;
  num rating;
  String address, id, icon, name, htmlPhotoLink;
  //bool open_now;
  //int price_level;

  Restaurant.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.lat =  json['geometry']['location']['lat'];
    this.lon = json['geometry']['location']['lng'];
    this.rating = json['rating'];
    this.address = json['vicinity'];
    this.id = json['id'];
    this.icon = json['icon'];
    this.htmlPhotoLink = json['photos'][0]['html_attributions'][0];

    //this.open_now = json['opening_hours']['open_now'];
    //this.price_level = json['price_level'];
  }
}