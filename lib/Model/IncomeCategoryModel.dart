// To parse this JSON data, do
//
//     final incomeCategory = incomeCategoryFromJson(jsonString);

import 'dart:convert';

IncomeCategory incomeCategoryFromJson(String str) => IncomeCategory.fromMap(json.decode(str));

String incomeCategoryToJson(IncomeCategory data) => json.encode(data.toMap());

class IncomeCategory {
  int id;
  String name;
  double amount;

  IncomeCategory({
    this.id,
    this.name,
    this.amount,
  });

  factory IncomeCategory.fromMap(Map<String, dynamic> json) => new IncomeCategory(
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
