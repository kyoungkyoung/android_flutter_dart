import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Conferences extends StatelessWidget {
  const Conferences({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Conferences'),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          padding: EdgeInsets.all(8.0),
          children: [],
        ));
  }
}
