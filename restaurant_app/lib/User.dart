class User {
  Map <String, double> preferences;
  List <String> cuisine = [];
  User(double distance, double price, List<String> cuisine) {
    preferences['distance'] = distance;
    preferences['price'] = price;
    this.cuisine = cuisine;
  }
}
