// To parse this JSON data, do
//
//     final totalIncome = totalIncomeFromJson(jsonString);

import 'dart:convert';

List<TotalIncome> totalIncomeFromJson(String str) => new List<TotalIncome>.from(json.decode(str).map((x) => TotalIncome.fromMap(x)));

String totalIncomeToJson(List<TotalIncome> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toMap())));

class TotalIncome {
  double amount;

  TotalIncome({
    this.amount,
  });

  factory TotalIncome.fromMap(Map<String, dynamic> json) => new TotalIncome(
    amount: json["amount"],
  );

  Map<String, dynamic> toMap() => {
    "amount": amount,
  };
}
