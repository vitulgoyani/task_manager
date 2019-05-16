// To parse this JSON data, do
//
//     final listMaster = listMasterFromJson(jsonString);

import 'dart:convert';

ListMaster listMasterFromJson(String str) => ListMaster.fromMap(json.decode(str));

String listMasterToJson(ListMaster data) => json.encode(data.toMap());

class ListMaster {
  int id;
  String name;
  String color;
  String sound;

  ListMaster({
    this.id,
    this.name,
    this.color,
    this.sound,
  });

  factory ListMaster.fromMap(Map<String, dynamic> json) => new ListMaster(
    id: json["id"],
    name: json["name"],
    color: json["color"],
    sound: json["sound"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "color": color,
    "sound": sound,
  };
}
