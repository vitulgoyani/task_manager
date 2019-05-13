// To parse this JSON data, do
//
//     final incomeEntry = incomeEntryFromJson(jsonString);

import 'dart:convert';

IncomeEntry incomeEntryFromJson(String str) => IncomeEntry.fromMap(json.decode(str));

String incomeEntryToJson(IncomeEntry data) => json.encode(data.toMap());

class IncomeEntry {
  int id;
  String date;
  int incomeCategoryId;
  int resourceTypeId;
  int amount;
  String note;
  String image;

  IncomeEntry({
    this.id,
    this.date,
    this.incomeCategoryId,
    this.resourceTypeId,
    this.amount,
    this.note,
    this.image,
  });

  factory IncomeEntry.fromMap(Map<String, dynamic> json) => new IncomeEntry(
    id: json["id"],
    date: json["date"],
    incomeCategoryId: json["income_category_id"],
    resourceTypeId: json["resource_type_id"],
    amount: json["amount"],
    note: json["note"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "date": date,
    "income_category_id": incomeCategoryId,
    "resource_type_id": resourceTypeId,
    "amount": amount,
    "note": note,
    "image": image,
  };
}
