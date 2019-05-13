// To parse this JSON data, do
//
//     final totalExpense = totalExpenseFromJson(jsonString);

import 'dart:convert';

List<TotalExpense> totalExpenseFromJson(String str) => new List<TotalExpense>.from(json.decode(str).map((x) => TotalExpense.fromMap(x)));

String totalExpenseToJson(List<TotalExpense> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toMap())));

class TotalExpense {
  double amount;

  TotalExpense({
    this.amount,
  });

  factory TotalExpense.fromMap(Map<String, dynamic> json) => new TotalExpense(
    amount: json["amount"],
  );

  Map<String, dynamic> toMap() => {
    "amount": amount,
  };
}
