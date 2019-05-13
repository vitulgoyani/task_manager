import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 4.0,
              child: Container(
                height: MediaQuery.of(context).size.height - 138,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(child: Column(children: <Widget>[

                ],)),
              ),
            ),
            Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 40.0,
                        onPressed: null),
                    IconButton(
                        icon: Icon(Icons.done), iconSize: 40.0, onPressed: null)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
