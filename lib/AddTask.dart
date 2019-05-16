import 'package:flutter/material.dart';
import 'package:task_manager/AddList.dart';
import 'package:task_manager/Model/ListsModel.dart';
import 'package:task_manager/Database/DatabaseHelper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  int currentlistIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    double mediawidth = MediaQuery.of(context).size.width;
    double mediaheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Card(
                  elevation: 4.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 138,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              maxLines: 2,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "Task"),
                              style: TextStyle(
                                  fontSize: 36.0,
                                  textBaseline: TextBaseline.ideographic),
                              controller: _nameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 140),
                            child: Container(
                              width: mediawidth,
                              height: 45.0,
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return AddList();
                                      }));
                                    },
                                    child: Container(
                                      width: 60.0,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                              height: 35.0,
                                              color: Colors.transparent,
                                              child: Icon(Icons.add)),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.black12))),
                                            height: 8.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FutureBuilder<List<ListMaster>>(
                                      future: DBProvider.db.getAllLists(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<ListMaster>>
                                              snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data.length > 0) {
                                          return Expanded(
                                            child: ListView.builder(
                                              itemCount: snapshot.data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int i) {
                                                ListMaster list =
                                                    snapshot.data[i];
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      currentlistIndex = i;
                                                      print(list.name);
                                                    });
                                                  },
                                                  child: listract(
                                                      list.color,
                                                      list.name,
                                                      i == currentlistIndex,
                                                      context),
                                                );
                                              },
                                              physics: BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                            ),
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 210),
                            child: Container(
                              width: mediawidth,
                              height: 200.0,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 30.0,
                                              ),
                                              Text(
                                                "Date",
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    color: Colors.black54),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              InkWell(
                                                onTap: () =>
                                                    _selectDate(context),
                                                child: AutoSizeText(
                                                  formatDate(_date,
                                                      [dd, ' ', M, ' ', yyyy]),
                                                  style:
                                                      TextStyle(fontSize: 38.0),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 30.0,
                                              ),
                                              Text(
                                                "Time",
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    color: Colors.black54),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              InkWell(
                                                onTap: () =>
                                                    _selectTime(context),
                                                child: AutoSizeText(
                                                  _time.format(context),
                                                  style:
                                                      TextStyle(fontSize: 38.0),
                                                  maxLines: 1,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              AutoSizeText(
                                                "Notification: off",
                                                style: TextStyle(
                                                  fontSize: 22.0,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          /*Positioned(
                            bottom: 0.0,
                            child: Column(
                              children: <Widget>[
                                Divider(),
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.black12))),
                                    height: 60.0,
                                    width: mediawidth,
                                    child: Center(
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            color: Colors.black54),
                                      ),
                                    )),
                              ],
                            ),
                          ),*/
                        ],
                      ),
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
                          onPressed: null)
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

  Widget listract(
      String listcolor, String name, bool isSelected, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        height: 80.0,
        width: 120.0,
        child: Column(
          children: <Widget>[
            Container(
                height: 35.0,
                color: Colors.white,
                child: Center(
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 28),
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            isSelected
                ? Container(
                    decoration: BoxDecoration(
                        color: Color(int.parse(listcolor)),
                        border:
                            Border(bottom: BorderSide(color: Colors.black12))),
                    height: 8.0,
                  )
                : Container(
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black12))),
                    height: 8.0,
                  ),
          ],
        ),
      ),
    );
  }

  datedata() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          content: SingleChildScrollView(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.play_arrow),
                ),
                title: Text("Select Date"),
                onTap: () {
                  setState(() {});
                  Navigator.pop(context);
                }),
          )),
        );
      },
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2019),
      lastDate: DateTime(3000),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null) {
      setState(() {
        _time = picked;
      });
    }
  }
}
