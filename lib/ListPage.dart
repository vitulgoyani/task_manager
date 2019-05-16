import 'package:flutter/material.dart';
import 'package:task_manager/AddList.dart';
import 'package:task_manager/AddTask.dart';
import 'package:task_manager/DashBoard.dart';
import 'package:task_manager/classlist/AppBarclass.dart';
import 'package:task_manager/Database/DatabaseHelper.dart';
import 'package:task_manager/Model/ListsModel.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  hexStringToHexInt(String hex) {
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    int val = int.parse(hex, radix: 16);
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          appbar("Lists"),
          SizedBox(
            height: 30.0,
          ),
          FutureBuilder<List<ListMaster>>(
              future: DBProvider.db.getAllLists(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ListMaster>> snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  return Expanded(
                      child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int i) {
                      ListMaster listdata = snapshot.data[i];
                      return listbox(
                          listdata.name, listdata.id, listdata.color);
                    },
                  ));
                } else {
                  return Expanded(
                    child: Center(
                      child: Text("No any Lists"),
                    ),
                  );
                }
              }),
          bottomnvigation(),
        ],
      ),
    );
  }

/* decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.black26,blurRadius: 5.0,spreadRadius: 0.1)
        ]),*/
  Widget listbox(String name, int id, String colorss) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: Row(
          children: <Widget>[
            Container(
              width: 15.0,
              height: 130.0,
              decoration: BoxDecoration(
                  color: Color(int.parse(colorss)),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0))),
            ),
            Container(
              height: 130.0,
              width: MediaQuery.of(context).size.width - 39,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 30.0),
                            ),
                            Text(
                              "160 tasks",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Text(
                              "Take Tea from jivraj tea at varachha",
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black45),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget bottomnvigation() {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.dashboard),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Text("+  New List",style: TextStyle(fontSize: 20.0,color: Colors.black45),),
            IconButton(icon: Icon(Icons.add), onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return AddList();
                  }));
            }),
          ],
        ),
      ),
    );
  }
}
