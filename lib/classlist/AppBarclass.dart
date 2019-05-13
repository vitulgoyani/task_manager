import 'package:flutter/material.dart';
Widget appbar(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 50.0, left: 20.0),
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 50.0),
          ),
        ],
      ),
    ),
  );
}

Widget appbardash() {
  return Padding(
    padding: EdgeInsets.only(top: 50.0, left: 20.0),
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Today",
            style: TextStyle(fontSize: 50.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "20th Sep 2018",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}