import 'package:flutter/material.dart';
import 'package:restaurant_app/RestaurantCardInfo/Restaurant.dart';
import 'package:url_launcher/url_launcher.dart';

/// Creates one restaurant card
class RestaurantListItem extends Column {
  RestaurantListItem(
      Restaurant restaurant, double scaleFactor, BuildContext context)
      : super(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - (53.0 * scaleFactor),
            height: (MediaQuery.of(context).size.height / 4),
            decoration: new BoxDecoration(
              //borderRadius: new BorderRadius.circular(20.0),
              color: const Color(0xff7c94b6),
              image: new DecorationImage(
                image: new NetworkImage(restaurant.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Card(
            color: Theme.of(context).primaryColor,
            margin: EdgeInsets.only(
                //top: 20.0 * scaleFactor,
                bottom: 30.0 * scaleFactor,
                left: 25.0 * scaleFactor,
                right: 25.0 * scaleFactor),
            child: ExpansionTile(
                backgroundColor: Theme.of(context).primaryColorDark,
                title: //<Widget> [
                    Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
//                      onTap: () {
//                        Navigator.push(
//                          context,
//                          new MyCustomRoute(
//                              builder: (BuildContext context) =>
//                                  new RestaurantPage(restaurant)),
//                        );
//                      },
                      title: Text(restaurant.name,
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 65.0 * scaleFactor,
                          )),
                      subtitle: Row(
                        children: _buildSubtitle(restaurant, scaleFactor),
                      ),
                    ),
                  ],
                ),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButtonColumn(restaurant, scaleFactor, Icons.call, 'CALL', context),
                      buildButtonColumn(restaurant, scaleFactor, Icons.near_me, 'ROUTE', context),
                      buildButtonColumn(restaurant, scaleFactor, Icons.language, 'YELP', context),
                    ],
                  ),
                  Column(
                    children: [
                      buildReviews(restaurant)
                    ]
                  )
                ]),
          )
        ]);
}

Text buildReviews(Restaurant rest) {
  Text textField = Text('');
  for (Map m in rest.reviews) {
    textField = Text(m['text'].toString());
  }
  return textField;
}

List <Widget> _buildSubtitle(Restaurant restaurant, double scaleFactor) {

  List <Widget> subtitle = List();

  int i = 0;
  for(; i < restaurant.rating - 1; i++)
    subtitle.add(Icon(
      Icons.star,
      size: 50.0 * scaleFactor,
    ));

  if (restaurant.rating - restaurant.rating.truncate() >= 0.5) {
    subtitle.add(Icon(
        Icons.star_half,
        size: 50.0 * scaleFactor,
    ));
    i++;
  }

  for (; i < 5; i++)
        subtitle.add(Icon(
          Icons.star_border,
          size: 50.0 * scaleFactor,
        ));

  subtitle.add(
      Text('       ${restaurant.rating} (${restaurant.reviewCount})       ${(restaurant.distance * 00.0062137).round()/10.0} mi. away',
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: Colors.white,
          fontSize: 40.0 * scaleFactor,
        ))
  );

  return subtitle;
}

GestureDetector buildButtonColumn(Restaurant restaurant, double scaleFactor, IconData icon, String label, BuildContext context) {
  Color color = Colors.white;

  return GestureDetector(
      onTap: () {
        if (label == 'CALL') {
          if (restaurant.phone == null) {
            showDialog(
              context: context,
              child: new AlertDialog(
                title: new Text("No Phone Number"),
                content: new Text("This restaurant has no phone number."),
                actions: [
                  new FlatButton(
                    child: new Text("Ok",
                        style: new TextStyle(
                          color: Colors.white,
                        )),
                    //onPressed: () => Navigator.pop(context)
                  ),
                ],
              ),
            );
          } else
            launch("tel://${restaurant.phone}");
        } else if (label == 'ROUTE') {
          _launchURL(
              'https://www.google.com/maps/search/?api=1&query=${restaurant.address}');
        } else if (label == 'YELP') {
          if (restaurant.yelpUrl == null) {
            showDialog(
              context: context,
              child: new AlertDialog(
                title: new Text("No Website"),
                content: new Text("This restaurant has no website."),
                actions: [
                  new FlatButton(
                    child: new Text("Ok",
                        style: new TextStyle(
                          color: Colors.white,
                        )),
                    //onPressed: () => Navigator.pop(context)
                  ),
                ],
              ),
            );
          } else
            _launchURL(restaurant.yelpUrl);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.0 * scaleFactor),
            child: Icon(icon, color: color),
          ),
          Container(
              padding: EdgeInsets.only(bottom: 20.0 * scaleFactor),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 30.0 * scaleFactor,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              )),
        ],
      ));
}

_launchURL(link) async {
  String url = link;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
