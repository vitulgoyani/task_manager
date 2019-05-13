// To parse this JSON data, do
//
//     final currencyType = currencyTypeFromJson(jsonString);

import 'dart:convert';

CurrencyType currencyTypeFromJson(String str) => CurrencyType.fromMap(json.decode(str));

String currencyTypeToJson(CurrencyType data) => json.encode(data.toMap());

class CurrencyType {
  int id;
  String locale;
  String symbol;

  CurrencyType({
    this.id,
    this.locale,
    this.symbol,
  });

  factory CurrencyType.fromMap(Map<String, dynamic> json) => new CurrencyType(
    id: json["id"],
    locale: json["locale"],
    symbol: json["symbol"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "locale": locale,
    "symbol": symbol,
  };
}
