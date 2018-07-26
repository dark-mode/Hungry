import 'package:flutter/material.dart';

import 'package:material_search/material_search.dart';

class CuisinePage extends StatefulWidget {
  CuisinePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CuisinePageState createState() => new _CuisinePageState();
}

class _CuisinePageState extends State<CuisinePage> {
  final _names =  [
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

  String _name = 'No one';

  final _formKey = new GlobalKey<FormState>();

  _buildMaterialSearchPage(BuildContext context) {
    return new MaterialPageRoute<String>(
        settings: new RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return new Material(
            child: new MaterialSearch<String>(
              placeholder: 'Search',
              results: _names.map((String v) => new MaterialSearchResult<String>(
                icon: Icons.person,
                value: v,
                text: "$v",
              )).toList(),
              filter: (dynamic value, String criteria) {
                return value.toLowerCase().trim()
                    .contains(new RegExp(r'' + criteria.toLowerCase().trim() + ''));
              },
              onSelect: (dynamic value) => Navigator.of(context).pop(value),
              onSubmit: (String value) => Navigator.of(context).pop(value),
            ),
          );
        }
    );
  }

  _showMaterialSearch(BuildContext context) {
    Navigator.of(context)
        .push(_buildMaterialSearchPage(context))
        .then((dynamic value) {
      setState(() => _name = value as String);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cuisine Page"),
        actions: <Widget>[
          new IconButton(
            onPressed: () {
              _showMaterialSearch(context);
            },
            tooltip: 'Search',
            icon: new Icon(Icons.search),
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _showMaterialSearch(context);
        },
        tooltip: 'Search',
        child: new Icon(Icons.search),
      ),
    );
  }
}
