// To parse this JSON data, do
//
//     final taskMaster = taskMasterFromJson(jsonString);

import 'dart:convert';

TaskMaster taskMasterFromJson(String str) => TaskMaster.fromMap(json.decode(str));

String taskMasterToJson(TaskMaster data) => json.encode(data.toMap());

class TaskMaster {
  int id;
  String taskstatus;
  String datetime;
  String name;
  String note;
  String repeatCategory;
  String notiStatus;
  String notiSound;
  String notiTime;
  String autoComplete;
  String image;
  int listMasterId;

  TaskMaster({
    this.id,
    this.taskstatus,
    this.datetime,
    this.name,
    this.note,
    this.repeatCategory,
    this.notiStatus,
    this.notiSound,
    this.notiTime,
    this.autoComplete,
    this.image,
    this.listMasterId,
  });

  factory TaskMaster.fromMap(Map<String, dynamic> json) => new TaskMaster(
    id: json["id"],
    taskstatus: json["taskstatus"],
    datetime: json["datetime"],
    name: json["name"],
    note: json["note"],
    repeatCategory: json["repeat_category"],
    notiStatus: json["noti_status"],
    notiSound: json["noti_sound"],
    notiTime: json["noti_time"],
    autoComplete: json["auto_complete"],
    image: json["image"],
    listMasterId: json["list_master_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "taskstatus": taskstatus,
    "datetime": datetime,
    "name": name,
    "note": note,
    "repeat_category": repeatCategory,
    "noti_status": notiStatus,
    "noti_sound": notiSound,
    "noti_time": notiTime,
    "auto_complete": autoComplete,
    "image": image,
    "list_master_id": listMasterId,
  };
}
