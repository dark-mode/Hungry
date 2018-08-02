/// Holds each restaurant and stores its information.
class Restaurant {
  double distance, rating;
  String id,
      name,
      imageUrl,
      yelpUrl,
      address,
      phone,
      displayPhone;
  int reviewCount, price;
  bool isOpen;
  Map<String, double> preferences;
  List<dynamic> categories;
  List<dynamic> transactions;

  Restaurant.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.distance = json['distance'];
    this.id = json['id'];
    this.imageUrl = json['image_url'];
    this.isOpen = !json['is_closed'];
    this.yelpUrl = json['url'];
    this.reviewCount = json['review_count'];
    this.categories = json['categories'];
    this.rating = json['rating'];
    this.transactions = json['transactions'];
    this.address = '';
    this.phone = json['phone'];
    this.displayPhone = json['display_phone'];
    if (json['price'] != null) {
      this.price = json['price'].length;
    }
    if (json['location']['display_address'] != null) {
//      json['location']['display_address'].forEach((adr) =>
//      address += adr + ' ');
        StringBuffer ad = StringBuffer();
        for (String addressLine in json['location']['display_address']) {
          ad.write(addressLine + ', ');
        }
        address = ad.toString().substring(0, ad.toString().length - 2);
    }
  }

  setPlaceDetails(
      List<dynamic> openingHours, String phoneNumber, String website) {
  }
}
