// To parse this JSON data, do
//
//     final expenseCategory = expenseCategoryFromJson(jsonString);

import 'dart:convert';

ExpenseCategory expenseCategoryFromJson(String str) => ExpenseCategory.fromMap(json.decode(str));

String expenseCategoryToJson(ExpenseCategory data) => json.encode(data.toMap());

class ExpenseCategory {
  int id;
  String name;
  double amount;

  ExpenseCategory({
    this.id,
    this.name,
    this.amount,
  });

  factory ExpenseCategory.fromMap(Map<String, dynamic> json) => new ExpenseCategory(
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
