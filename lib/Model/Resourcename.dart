// To parse this JSON data, do
//
//     final resourcename = resourcenameFromJson(jsonString);

import 'dart:convert';

List<Resourcename> resourcenameFromJson(String str) => new List<Resourcename>.from(json.decode(str).map((x) => Resourcename.fromMap(x)));

String resourcenameToJson(List<Resourcename> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toMap())));

class Resourcename {
  String name;

  Resourcename({
    this.name,
  });

  factory Resourcename.fromMap(Map<String, dynamic> json) => new Resourcename(
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
  };
}
