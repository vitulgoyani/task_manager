// To parse this JSON data, do
//
//     final categoryname = categorynameFromJson(jsonString);

import 'dart:convert';

List<Categoryname> categorynameFromJson(String str) => new List<Categoryname>.from(json.decode(str).map((x) => Categoryname.fromMap(x)));

String categorynameToJson(List<Categoryname> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toMap())));

class Categoryname {
  String name;

  Categoryname({
    this.name,
  });

  factory Categoryname.fromMap(Map<String, dynamic> json) => new Categoryname(
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
  };
}
