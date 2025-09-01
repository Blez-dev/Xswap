// To parse this JSON data, do
//
//     final exchangeConversion = exchangeConversionFromJson(jsonString);

import 'dart:convert';

ExchangeConversion exchangeConversionFromJson(String str) => ExchangeConversion.fromJson(json.decode(str));

String exchangeConversionToJson(ExchangeConversion data) => json.encode(data.toJson());

class ExchangeConversion {
  double estimatedAmount;
  double networkFee;
  String transactionSpeedForecast;
  dynamic warningMessage;
  String rateId;
  DateTime validUntil;

  ExchangeConversion({
    required this.estimatedAmount,
    required this.networkFee,
    required this.transactionSpeedForecast,
    required this.warningMessage,
    required this.rateId,
    required this.validUntil,
  });

  factory ExchangeConversion.fromJson(Map<String, dynamic> json) => ExchangeConversion(
    estimatedAmount: json["estimatedAmount"]?.toDouble(),
    networkFee: json["networkFee"]?.toDouble(),
    transactionSpeedForecast: json["transactionSpeedForecast"],
    warningMessage: json["warningMessage"],
    rateId: json["rateId"],
    validUntil: DateTime.parse(json["validUntil"]),
  );

  Map<String, dynamic> toJson() => {
    "estimatedAmount": estimatedAmount,
    "networkFee": networkFee,
    "transactionSpeedForecast": transactionSpeedForecast,
    "warningMessage": warningMessage,
    "rateId": rateId,
    "validUntil": validUntil.toIso8601String(),
  };
}
