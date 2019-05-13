import 'dart:async';
import 'package:task_manager/Database/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:task_manager/Model/ListsModel.dart';

class AddList extends StatefulWidget {
  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  Color currentColor = Colors.blue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  void changeColorAndPopout(Color color) => setState(() {
    currentColor = color;
  });

  void _addList() async {
    await DBProvider.db.newList(ListMaster(
        name: _nameController.text, color: currentColor.toString().substring(6,16).toString()));
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Add List",
                  style: TextStyle(fontSize: 36.0),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Form(
                key: _formKey,
                child: Card(
                  elevation: 4.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 200,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            controller: _nameController,
                            style: TextStyle(fontSize: 20.0),
                            decoration: InputDecoration(
                              hintText: "List Name",
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Name';
                              }
                            },
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/1.9,
                            child: MaterialPicker(
                              enableLabel: true,
                              pickerColor: currentColor,
                              onColorChanged: changeColorAndPopout,

                            ),
                          ),
                        ],
                      )),
                    ),
                  ),
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
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      IconButton(
                          icon: Icon(Icons.done),
                          iconSize: 40.0,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _addList();
                            }
                          },)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
