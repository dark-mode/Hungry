import 'package:flutter/material.dart';
import 'package:restaurant_app/MaterialSearchResults.dart';
import 'package:restaurant_app/Trie.dart';
import 'package:restaurant_app/RestaurantCardViewer/ResultsPage.dart';
import 'package:restaurant_app/UserPreferences/User.dart';

class MaterialSearch extends StatefulWidget {
  _MaterialSearchState hP;
  @override
  _MaterialSearchState createState() => hP;

  MaterialSearch(lat, lon) {
    hP = new _MaterialSearchState(lat, lon, null);
  }

  MaterialSearch.withUser(lat, lon, user) {
    hP = new _MaterialSearchState(lat, lon, user);
  }
}

class _MaterialSearchState extends State<MaterialSearch> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  FocusNode _myFocusNode;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    _myFocusNode.dispose();

    super.dispose();
  }

  double _lat, _lon;

  Set<String> _selectedCuisines;
  List<String> _cuisines;
  Trie _trie;
  User _user;
  Icon _rightIcon;
  TextEditingController _controller;
  _MaterialSearchState(this._lat, this._lon, this._user) {
    _controller = new TextEditingController();
    _myFocusNode = FocusNode();
    _selectedCuisines = Set();
    _rightIcon = new Icon(Icons.search);
    _cuisines = [
      'Abruzzese',
      'Acai Bowls',
      'Afghan',
      'African',
      'Alentejo',
      'Algarve',
      'Alsatian',
      'Altoatesine',
      'American (New)',
      'Andalusian',
      'Apulian',
      'Arab Pizza',
      'Arabian',
      'Argentine',
      'Armenian',
      'Arroceria / Paella',
      'Asian Fusion',
      'Asturian',
      'Australian',
      'Austrian',
      'Auvergnat',
      'Azores',
      'Backshop',
      'Baden',
      'Bagels',
      'Baguettes',
      'Bakeries',
      'Bangladeshi',
      'Barbeque',
      'Basque',
      'Bavarian',
      'Beer',
      'Beer Garden',
      'Beer Hall',
      'Beira',
      'Beisl',
      'Belgian',
      'Bento',
      'Berrichon',
      'Beverage Store',
      'Bistros',
      'Black Sea',
      'Blowfish',
      'Boba',
      'Bourguignon',
      'Brasseries',
      'Brazilian Empanadas',
      'Brazilian',
      'Breakfast & Brunch',
      'Breweries',
      'Brewpubs',
      'British',
      'Bubble Tea',
      'Buffets',
      'Bulgarian',
      'Burgers',
      'Burmese',
      'Butcher',
      'CSA',
      'Cafes',
      'Cafeteria',
      'Cajun/Creole',
      'Calabrian',
      'Cambodian',
      'Canadian',
      'Candy Stores',
      'Canteen',
      'Cantonese',
      'Caribbean',
      'Catalan',
      'Central Brazilian',
      'Chee Kufta',
      'Cheese Shops',
      'Cheesesteaks',
      'Chicken Shop',
      'Chicken Wings',
      'Chilean',
      'Chimney Cakes',
      'Chinese',
      'Chocolatiers & Shops',
      'Churros',
      'Cideries',
      'Coffee & Tea Supplies',
      'Coffee & Tea',
      'Coffee Roasteries',
      'Colombian',
      'Comfort Food',
      'Congee',
      'Convenience Stores',
      'Conveyor Belt Sushi',
      'Corsican',
      'Creperies',
      'Cuban',
      'Cucina campana',
      'Cupcakes',
      'Curry Sausage',
      'Custom Cakes',
      'Cypriot',
      'Czech',
      'Czech/Slovakian',
      'Dagashi',
      'Danish',
      'Delicatessen',
      'Delis',
      'Desserts',
      'Dim Sum',
      'Diners',
      'Dinner Theater',
      'Distilleries',
      'Do-It-Yourself Food',
      'Dominican',
      'Donairs',
      'Donburi',
      'Donuts',
      'Dried Fruit',
      'Dumplings',
      'Eastern European',
      'Eastern German',
      'Eastern Mexican',
      'Egyptian',
      'Emilian',
      'Empanadas',
      'Ethical Grocery',
      'Ethiopian',
      'Fado Houses',
      'Falafel',
      'Farmers Market',
      'Fast Food',
      'Filipino',
      'Fischbroetchen',
      'Fish & Chips',
      'Fishmonger',
      'Flatbread',
      'Flemish',
      'Fondue',
      'Food Court',
      'Food Delivery Services',
      'Food Stands',
      'Food Trucks',
      'Franconian',
      'Freiduria',
      'French Southwest',
      'French',
      'Friterie',
      'Friulan',
      'Frozen Food',
      'Fruits & Veggies',
      'Fuzhou',
      'Galician',
      'Game Meat',
      'Gastropubs',
      'Gelato',
      'Georgian',
      'German',
      'Giblets',
      'Gluten-Free',
      'Gozleme',
      'Greek',
      'Grocery',
      'Guamanian',
      'Gyudon',
      'Hainan',
      'Haitian',
      'Hakka',
      'Halal',
      'Hand Rolls',
      'Hawaiian',
      'Hawker Centre',
      'Health Markets',
      'Henghwa',
      'Herbs & Spices',
      'Hessian',
      'Heuriger',
      'Himalayan/Nepalese',
      'Hokkien',
      'Homemade Food',
      'Honduran',
      'Honey',
      'Hong Kong Style Cafe',
      'Horumon',
      'Hot Dogs',
      'Hot Pot',
      'Hunan',
      'Hungarian',
      'Iberian',
      'Ice Cream & Frozen Yogurt',
      'Imported Food',
      'Indian',
      'Indonesian',
      'International Grocery',
      'International',
      'Internet Cafes',
      'Irish',
      'Island Pub',
      'Israeli',
      'Italian',
      'Izakaya',
      'Jaliscan',
      'Japanese Curry',
      'Japanese Sweets',
      'Japanese',
      'Jewish',
      'Juice Bars & Smoothies',
      'Kaiseki',
      'Kebab',
      'Kiosk',
      'Kombucha',
      'Kopitiam',
      'Korean',
      'Kosher',
      'Kurdish',
      'Kushikatsu',
      'Lahmacun',
      'Laos',
      'Laotian',
      'Latin American',
      'Lebanese',
      'Ligurian',
      'Live/Raw Food',
      'Lumbard',
      'Lyonnais',
      'Macarons',
      'Madeira',
      'Malaysian',
      'Mamak',
      'Mauritius',
      'Meat Shops',
      'Meatballs',
      'Mediterranean',
      'Mexican',
      'Middle Eastern',
      'Milk Bars',
      'Milkshake Bars',
      'Minho',
      'Modern Australian',
      'Modern European',
      'Mongolian',
      'Moroccan',
      'Mulled Wine',
      'Napoletana',
      'Nasi Lemak',
      'New Mexican Cuisine',
      'New Zealand',
      'Nicaraguan',
      'Nicoise',
      'Night Food',
      'Nikkei',
      'Noodles',
      'Norcinerie',
      'Northeastern Brazilian',
      'Northern Brazilian',
      'Northern German',
      'Northern Mexican',
      'Nyonya',
      'Oaxacan',
      'Oden',
      'Okinawan',
      'Okonomiyaki',
      'Olive Oil',
      'Onigiri',
      'Open Sandwiches',
      'Organic Stores',
      'Oriental',
      'Ottoman Cuisine',
      'Oyakodon',
      'PF/Comercial',
      'Pakistani',
      'Palatine',
      'Pan Asian',
      'Panzerotti',
      'Parent Cafes',
      'Parent Cafes',
      'Parma',
      'Pasta Shops',
      'Patisserie/Cake Shop',
      'Pekinese',
      'Persian/Iranian',
      'Peruvian',
      'Piadina',
      'Piemonte',
      'Pierogis',
      'Pita',
      'Pizza',
      'Poke',
      'Polish',
      'Polynesian',
      'Pop-Up Restaurants',
      'Popcorn Shops',
      'Portuguese',
      'Potatoes',
      'Poutineries',
      'Pretzels',
      'Provencal',
      'Pub Food',
      'Pueblan',
      'Puerto Rican',
      'Ramen',
      'Reunion',
      'Rhinelandian',
      'Ribatejo',
      'Rice',
      'Robatayaki',
      'Rodizios',
      'Roman',
      'Romanian',
      'Rotisserie Chicken',
      'Russian',
      'Salad',
      'Salumerie',
      'Salvadoran',
      'Sandwiches',
      'Sardinian',
      'Scandinavian',
      'Schnitzel',
      'Scottish',
      'Seafood Markets',
      'Seafood',
      'Senegalese',
      'Serbo Croatian',
      'Shanghainese',
      'Shaved Ice',
      'Shaved Snow',
      'Sicilian',
      'Signature Cuisine',
      'Singaporean',
      'Slovakian',
      'Smokehouse',
      'Soba',
      'Soul Food',
      'Soup',
      'South African',
      'Southern',
      'Spanish',
      'Specialty Food',
      'Sri Lankan',
      'Steakhouses',
      'Street Vendors',
      'Sugar Shacks',
      'Sukiyaki',
      'Supper Clubs',
      'Sushi Bars',
      'Swabian',
      'Swedish',
      'Swiss Food',
      'Syrian',
      'Szechuan',
      'Tabernas',
      'Tacos',
      'Taiwanese',
      'Taiyaki',
      'Takoyaki',
      'Tamales',
      'Tapas Bars',
      'Tapas/Small Plates',
      'Tavola Calda',
      'Tea Rooms',
      'Tempura',
      'Teochew',
      'Teppanyaki',
      'Tex-Mex',
      'Thai',
      'Themed Cafes',
      'Tofu Shops',
      'Tonkatsu',
      'Torshi',
      'Tortillas',
      'Traditional American',
      'Traditional Norwegian',
      'Traditional Swedish',
      'Tras-os-Montes',
      'Trattorie',
      'Trinidadian',
      'Turkish Ravioli',
      'Turkish',
      'Tuscan',
      'Udon',
      'Ukrainian',
      'Unagi',
      'Uzbek',
      'Vegan',
      'Vegetarian',
      'Venetian',
      'Venezuelan',
      'Venison',
      'Vietnamese',
      'Waffles',
      'Water Stores',
      'Western Style Japanese Food',
      'Wine Tasting Room',
      'Wineries',
      'Wok',
      'Wraps',
      'Yakiniku',
      'Yakitori',
      'Yucatan',
      'Yugoslav',
      'Zapiekanka',
      'Wine & Spirits'
    ];

    _trie = Trie.list(_cuisines);
  }



  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    double scaleFactor =
        MediaQuery.of(context).textScaleFactor / 2.5;

    Icon _rightIcon;

    if (_cuisines.length < 396) { //! oiriginal length!!!
      _rightIcon = new Icon(Icons.clear);
      print("change " + _cuisines.length.toString());
    } else {
      _rightIcon = new Icon(Icons.search);
    }

    return MaterialApp(
      title: "Hungry",
      home: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            title: Row(
              children: <Widget>[
//                Container(
//                  padding: EdgeInsets.only(right: 5.0),
//                  child: new Chip(
//                    avatar: new CircleAvatar(
//                      backgroundColor: Colors.grey.shade800,
//                      child: new Text('AB'),
//                    ),
//                    label: new Text('Aaron Burr'),
//                  ),
//                ),
                IconButton(
                  padding: EdgeInsets.only(right: 50.0 * scaleFactor),
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Flexible(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    focusNode: _myFocusNode,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60.0 * scaleFactor,
                        fontFamily: 'Eczar'
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search on Hungry',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 60.0 * scaleFactor,
                          fontFamily: 'Eczar'
                      ),
                    ),
                    onSubmitted: (text) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultsPage.cuisines(_lat, _lon, _selectedCuisines, _user)),
                      );
                    },
                    onChanged: (text) {
                      setState(() {
                        _cuisines = _trie.getAllWordsWithPrefix(text);
                      });
                    },
                  ),
                )
              ],
            ),
            actions: _controller.text.length == 0 ? [
              new IconButton(
                  icon: new Icon(Icons.search),
                  onPressed: () {
                    if (MediaQuery.of(context).viewInsets.bottom == 0) {//keyboard is not already up
                      setState(() {
                        FocusScope.of(context).reparentIfNeeded(_myFocusNode);
                      });
                    }
                  }
              )
            ] : [
              new IconButton(
                  icon: new Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      _cuisines = _trie.getAllWords();
                    });
                  }
              ),
            ],
          ),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 20.0 * scaleFactor, right: 22.0 * scaleFactor),
                child: FloatingActionButton(
                  tooltip: "Clear All",
                  backgroundColor: Colors.red,
                  mini: true,
                  heroTag: null,
                  child: Icon(Icons.clear,color: Colors.white,),
                  onPressed: (){
                    setState(() {
                      _controller.clear();
                      _cuisines = _trie.getAllWords();
                      _selectedCuisines = Set<String>();
                    });
                  },
                ),
              ),
              FloatingActionButton(
                  heroTag: null,
                  tooltip: "Search",
                  child: new Icon(Icons.arrow_forward),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ResultsPage.cuisines(_lat, _lon, _selectedCuisines, _user)),
                    );
                  }),
            ],
          ),
          body: Container(child: MaterialSearchResults(_cuisines, _selectedCuisines, this))
      ),
    );
  }
}
