import 'package:flutter/material.dart';
import 'package:task_manager/AddTask.dart';
import 'package:task_manager/ListPage.dart';
import 'package:task_manager/classlist/AppBarclass.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  hexStringToHexInt(String hex) {
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    int val = int.parse(hex, radix: 16);
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            appbardash(),
            bottomnvigation(),
          ],
        );
      }),
    );
  }

  /* Widget appbar() {
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
  }*/

  Widget bottomnvigation() {
    return Positioned(
      bottom: 0.0,
      child: Container(
        height: 70.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ListPage();
                    }));
                  }),
              IconButton(icon: Icon(Icons.add), onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return AddTask();
                    }));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
