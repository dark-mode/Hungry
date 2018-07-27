import 'package:flutter/material.dart';
import 'package:restaurant_app/CuisineListItem.dart';
import 'package:restaurant_app/CuisineList.dart';

class CuisinePage extends StatefulWidget {
  _CuisinePageState hP = new _CuisinePageState();
  @override
  _CuisinePageState createState() => hP;
}

class _CuisinePageState extends State<CuisinePage> {
  noSuchMethod(Invocation i) => super.noSuchMethod(i);

  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';
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
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(child: CuisineList(_cuisines))
      ),
    );
  }
}