// To parse this JSON data, do
//
//     final resourseType = resourseTypeFromJson(jsonString);

import 'dart:convert';

ResourseType resourseTypeFromJson(String str) => ResourseType.fromMap(json.decode(str));

String resourseTypeToJson(ResourseType data) => json.encode(data.toMap());

class ResourseType {
  int id;
  String name;
  double amount;

  ResourseType({
    this.id,
    this.name,
    this.amount,
  });

  factory ResourseType.fromMap(Map<String, dynamic> json) => new ResourseType(
    id: json["id"],
    name: json["name"],
    amount: json["amount"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "amount": amount,
  };
}
