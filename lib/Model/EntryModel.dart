// To parse this JSON data, do
//
//     final entry = entryFromJson(jsonString);

import 'dart:convert';

Entry entryFromJson(String str) => Entry.fromMap(json.decode(str));

String entryToJson(Entry data) => json.encode(data.toMap());

class Entry {
  int id;
  String date;
  int incomeCategoryId;
  int expenseCategoryId;
  int resourceTypeId;
  double amount;
  String note;
  String image;
  int etype;

  Entry({
    this.id,
    this.date,
    this.incomeCategoryId,
    this.expenseCategoryId,
    this.resourceTypeId,
    this.amount,
    this.note,
    this.image,
    this.etype,
  });

  factory Entry.fromMap(Map<String, dynamic> json) => new Entry(
    id: json["id"],
    date: json["date"],
    incomeCategoryId: json["income_category_id"],
    expenseCategoryId: json["expense_category_id"],
    resourceTypeId: json["resource_type_id"],
    amount: json["amount"],
    note: json["note"],
    image: json["image"],
    etype: json["etype"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "date": date,
    "income_category_id": incomeCategoryId,
    "expense_category_id": expenseCategoryId,
    "resource_type_id": resourceTypeId,
    "amount": amount,
    "note": note,
    "image": image,
    "etype": etype,
  };
}
