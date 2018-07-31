import 'package:flutter/material.dart';
import 'package:restaurant_app/MaterialSearchResults.dart';

class MaterialSearch extends StatefulWidget {
  _MaterialSearchState hP = new _MaterialSearchState();
  @override
  _MaterialSearchState createState() => hP;
}

class _MaterialSearchState extends State<MaterialSearch> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  @override
  Widget build(BuildContext context) {
    final _cuisines =  [
      'Ainu',
      'Albanian',
      'Argentina',
      'Andhra',
      'Anglo-Indian',
      'Arab',
      'Armenian',
      'Assyrian',
      'Awadhi',
      'Azerbaijani',
      'Balochi',
      'Belarusian',
      'Bengali',
      'Berber',
      'Buddhist',
      'Bulgarian',
      'Cajun',
      'Chechen',
      'Chinese cuisine',
      'Chinese Islamic',
      'Circassian',
      'Crimean Tatar',
      'Estonian',
      'French',
      'Filipino',
      'Georgian',
      'Goan',
      'Goan Catholic',
      'Greek',
      'Hyderabad',
      'Indian Chinese',
      'Indian Singaporean cuisine',
      'Indonesian',
      'Inuit',
      'Italian American',
      'Japanese',
      'Jewish',
      'Karnataka',
      'Kazakh',
      'Korean',
      'Kurdish',
      'Latvian',
      'Lithuanian',
      'Louisiana Creole',
      'Maharashtrian',
      'Mangalorean',
      'Malay',
      'Keralite',
      'Malaysian Chinese cuisine',
      'Malaysian Indian cuisine',
      'Mexican',
      'Mordovian',
      'Mughal',
      'Native American',
      'Nepalese',
      'New Mexican',
      'Odia',
      'Parsi',
      'Pashtun',
      'Polish',
      'Pennsylvania Dutch',
      'Pakistani',
      'Peranakan',
      'Persian',
      'Peruvian',
      'Portuguese',
      'Punjabi',
      'Rajasthani',
      'Romanian',
      'Russian',
      'Sami',
      'Serbian',
      'Sindhi',
      'Slovak',
      'Slovenian',
      'Somali',
      'South Indian',
      'Sri Lankan',
      'Tatar',
      'Thai',
      'Turkish',
      'Tamil',
      'Udupi',
      'Ukrainian',
      'Yamal',
      'Zanzibari'
    ];

    return MaterialApp(
      title: "Basic List",
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            title: TextField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,

              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.search),
                tooltip: 'Search',
              ),
            ]
        ),
        body: Container(child: MaterialSearchResults(_cuisines))
      ),
    );
  }
}
