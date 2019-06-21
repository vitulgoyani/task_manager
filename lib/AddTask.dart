import 'package:flutter/material.dart';
import 'package:task_manager/AddList.dart';
import 'package:task_manager/Model/ListsModel.dart';
import 'package:task_manager/Database/DatabaseHelper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:task_manager/Model/TasksModel.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  Color allcolor;
  int currentlistIndex = 0;
  bool repeatbox = false;
  int listid = 1;
  bool chsu = false;
  bool chmo = false;
  bool chtu = false;
  bool chwe = false;
  bool chth = false;
  bool chfr = false;
  bool chsa = false;
  bool tasknoti = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  List repeatday = [];

  void _addTask() async {
    await DBProvider.db.newTask(TaskMaster(
        taskstatus:"undone",
        name: _nameController.text,
        datetime: _date.toString().substring(0,10),
        listMasterId: listid,
        notiStatus: tasknoti == true ? "on" : "off",
        repeatCategory: repeatbox == true ? repeatday.toString() : "off",
        image: "",
        autoComplete: "off",
        note: "",
        notiSound: "",
        notiTime: _time.format(context).toString()));
    setState(() {
      Navigator.pop(context);
    });
  }

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
                                  border: InputBorder.none,
                                  hintText: "Type Task"),
                              style: TextStyle(
                                  fontSize: 36.0,
                                  textBaseline: TextBaseline.ideographic),
                              controller: _nameController,
                              autofocus: true,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please Type Task';
                                }
                              },
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
                                                      allcolor = Color(
                                                          int.parse(
                                                              list.color));
                                                      listid = list.id;
                                                      print(listid);
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
                            padding: const EdgeInsets.only(top: 180),
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
                                                "Due Date",
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    color: Colors.black54),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (repeatbox == false)
                                                    _selectDate(context);
                                                },
                                                child: AutoSizeText(
                                                  formatDate(_date,
                                                      [dd, ' ', M, ' ', yyyy]),
                                                  style: repeatbox == true
                                                      ? TextStyle(
                                                          fontSize: 38.0,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: Colors.black45)
                                                      : TextStyle(
                                                          fontSize: 38.0,
                                                        ),
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
                                                "Due Time",
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
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    tasknoti == true
                                                        ? tasknoti = false
                                                        : tasknoti = true;
                                                  });
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    AutoSizeText(
                                                      "Notification: ",
                                                      style: TextStyle(
                                                        fontSize: 22.0,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                    tasknoti == true
                                                        ? AutoSizeText(
                                                            "On",
                                                            style: TextStyle(
                                                              fontSize: 22.0,
                                                            ),
                                                            maxLines: 1,
                                                          )
                                                        : AutoSizeText(
                                                            "Off",
                                                            style: TextStyle(
                                                              fontSize: 21.0,
                                                            ),
                                                            maxLines: 1,
                                                          )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          repeatbox == true
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 380),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Checkbox(
                                              activeColor: allcolor,
                                              value: chsu,
                                              onChanged: (bool val) {
                                                setState(() {
                                                  chsu = val;
                                                  chsu == true
                                                      ? repeatday.add("su")
                                                      : repeatday.remove("su");
                                                });
                                              }),
                                          Text("Su"),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Checkbox(
                                              activeColor: allcolor,
                                              value: chmo,
                                              onChanged: (bool val) {
                                                setState(() {
                                                  chmo = val;
                                                  chmo == true
                                                      ? repeatday.add("mo")
                                                      : repeatday.remove("mo");
                                                });
                                              }),
                                          Text("Mo"),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Checkbox(
                                              activeColor: allcolor,
                                              value: chtu,
                                              onChanged: (bool val) {
                                                setState(() {
                                                  chtu = val;
                                                  chtu == true
                                                      ? repeatday.add("tu")
                                                      : repeatday.remove("tu");
                                                });
                                              }),
                                          Text("Tu"),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Checkbox(
                                              activeColor: allcolor,
                                              value: chwe,
                                              onChanged: (bool val) {
                                                setState(() {
                                                  chwe = val;
                                                  chwe == true
                                                      ? repeatday.add("we")
                                                      : repeatday.remove("we");
                                                });
                                              }),
                                          Text("We"),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Checkbox(
                                              activeColor: allcolor,
                                              value: chth,
                                              onChanged: (bool val) {
                                                setState(() {
                                                  chth = val;
                                                  chth == true
                                                      ? repeatday.add("th")
                                                      : repeatday.remove("th");
                                                });
                                              }),
                                          Text("Th"),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Checkbox(
                                              activeColor: allcolor,
                                              value: chfr,
                                              onChanged: (bool val) {
                                                setState(() {
                                                  chfr = val;
                                                  chfr == true
                                                      ? repeatday.add("fr")
                                                      : repeatday.remove("fr");
                                                });
                                              }),
                                          Text("Fr"),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Checkbox(
                                              activeColor: allcolor,
                                              value: chsa,
                                              onChanged: (bool val) {
                                                setState(() {
                                                  chsa = val;
                                                  chsa == true
                                                      ? repeatday.add("sa")
                                                      : repeatday.remove("sa");
                                                });
                                              }),
                                          Text("Sa"),
                                        ],
                                      ), /*
                                      daycolumn("Sun", chsu),
                                      daycolumn("Mon", chmo),
                                      daycolumn("Tues", chtu),
                                      daycolumn("Wednes", chwe),
                                      daycolumn("Thurs", chsu),
                                      daycolumn("Fri", chsu),
                                      daycolumn("Satur", chsu),*/
                                    ],
                                  ))
                              : SizedBox(),
                          Padding(
                              padding: const EdgeInsets.only(top: 350),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Repeat Task",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Switch(
                                        activeColor: allcolor,
                                        value: repeatbox,
                                        onChanged: (bool val) {
                                          setState(() {
                                            repeatbox = val;
                                          });
                                        }),
                                  ],
                                ),
                              )),
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
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _addTask();
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

  Widget daycolumn(String day, bool short) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Checkbox(
            value: short,
            onChanged: (bool val) {
              setState(() {
                short = val;
                print(short);
              });
            }),
        Text(day),
      ],
    );
  }

  datedata() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          content: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[],
            ),
          ),
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
