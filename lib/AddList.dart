import 'dart:async';
import 'package:task_manager/Database/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:task_manager/Model/ListsModel.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AddList extends StatefulWidget {
  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  List soundlist = ["alarm_frenzy",
    "car_horn",
    "cheerful_2",
    "cooked",
    "creaky_wood_door",
    "door_knock",
    "enough_with_the_talking",
    "gentle_alarm",
    "glassy_soft_knock",
    "happy_ending",
    "hell_yeah_somewhat_calmer",
    "horse_whinnies",
    "man_laughing",
    "oringz_w424",
    "oringz_w426",
    "oringz_w432",
    "oringz_w447",
    "rise_and_shine",
    "seagulls_chatting",
    "serious_strike",
    "sisfus",
    "slow_spring_board",
    "soft_bells",
    "solemn",
    "sunny",
    "system_fault",
    "the_little_dwarf",
    "this_guitar",
    "what_friends_are_for",
    "who_are_you",
    "you_have_new_message",
    "youre_a_coward"
  ];
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  Color currentColor = Colors.blue;
  String currentSound = "slow_spring_board";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  bool selectcolor = false;

  void changeColorAndPopout(Color color) => setState(() {
        currentColor = color;
        selectcolor = true;
      });

  void _addList() async {
    await DBProvider.db.newList(ListMaster(sound: currentSound,
        name: _nameController.text,
        color: selectcolor == true
            ? currentColor.toString().substring(6, 16).toString()
            : "0xff4527a0"));
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                           autofocus: true,
                            controller: _nameController,
                            style: TextStyle(fontSize: 20.0),
                            decoration: InputDecoration(
                                hintText: "List Name",
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.audiotrack),
                                    onPressed: () => sounddata())),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Name';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 1.9,
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
                        },
                      )
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

  sounddata() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              child: ListView.builder(
                  itemCount: soundlist.length,
                  itemBuilder: (BuildContext context, int i) {
                    return ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            _assetsAudioPlayer.open(AssetsAudio(
                              asset: soundlist[i]+".mp3",
                              folder: "assets/",
                            ));
                            _assetsAudioPlayer.play();
                          },
                        ),
                        title: Text(soundlist[i]),
                        onTap: () {
                          setState(() {
                            currentSound = soundlist[i];
                            print(currentSound);
                          });
                          Navigator.pop(context);
                        });
                  }));
        });
  }
}
