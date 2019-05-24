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
