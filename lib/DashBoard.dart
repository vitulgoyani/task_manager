import 'package:flutter/material.dart';
import 'package:task_manager/AddTask.dart';
import 'package:task_manager/ListPage.dart';
import 'package:task_manager/Model/TasksModel.dart';
import 'package:task_manager/Model/ListsModel.dart';
import 'package:task_manager/Database/DatabaseHelper.dart';

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
      bottomNavigationBar: bottomnvigation(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          appbar(),
          Divider(),
          FutureBuilder<List<TaskMaster>>(
              future: DBProvider.db.getAllTasks(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TaskMaster>> snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  return Flexible(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        TaskMaster taskdata = snapshot.data[i];
                        return Column(
                          children: <Widget>[
                            FutureBuilder<List<ListMaster>>(
                                future: DBProvider.db
                                    .getlistdatabyid(taskdata.listMasterId),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<ListMaster>> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data.length > 0) {
                                    ListMaster listdata = snapshot.data[0];
                                    return ListTile(
                                      title: Text(taskdata.name),
                                      trailing: Text((taskdata.notiTime).toString()),
                                      leading: Checkbox(checkColor: Color(int.parse(listdata.color)),value: true, onChanged: null)
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                }),
                            /*Text(taskdata.name),
                            Text(taskdata.datetime),*/
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Text("No any Task"),
                    ),
                  );
                }
              }),
          /* Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Container(
                  width: 20.0,
                  height: 50.0,
                  color: Colors.white,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 20.0,
                  height: 50.0,
                  color: Colors.green,
                )
              ],
            ),
          ),
          FutureBuilder<List<TaskMaster>>(
              future: DBProvider.db.getAllTasks(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TaskMaster>> snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  return Flexible(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        TaskMaster taskdata = snapshot.data[i];
                        return Column(
                          children: <Widget>[
                            FutureBuilder<List<ListMaster>>(
                                future: DBProvider.db.getlistdatabyid(
                                    taskdata.listMasterId),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<ListMaster>>
                                    snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data.length > 0) {
                                    ListMaster listdata =
                                    snapshot.data[0];
                                    return Text(listdata.name);
                                  } else {
                                    return SizedBox();
                                  }
                                }),
                            Text(taskdata.name),
                            Text(taskdata.datetime),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Text("No any Task"),
                    ),
                  );
                }
              }),*/
        ],
      ),
    );
  }

  Widget appbar() {
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

  Widget bottomnvigation() {
    return BottomAppBar(
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
              Text(
                "+  New Task",
                style: TextStyle(fontSize: 20.0, color: Colors.black45),
              ),
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
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
