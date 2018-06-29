import 'package:flutter/material.dart';
import 'package:restaurant_app/ResultsPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to second screen when tapped!
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResultsPage()),
            );
          },
        ),
      ),
    );
  }
}