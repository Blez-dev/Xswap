// To parse this JSON data, do
//
//     final swapPairData = swapPairDataFromJson(jsonString);

import 'dart:convert';

List<SwapPairData> swapPairDataFromJson(String str) => List<SwapPairData>.from(json.decode(str).map((x) => SwapPairData.fromJson(x)));

String swapPairDataToJson(List<SwapPairData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SwapPairData {
  String from;
  String to;
  double rate;
  double minerFee;
  double min;
  double max;

  SwapPairData({
    required this.from,
    required this.to,
    required this.rate,
    required this.minerFee,
    required this.min,
    required this.max,
  });

  factory SwapPairData.fromJson(Map<String, dynamic> json) => SwapPairData(
    from: json["from"],
    to: json["to"],
    rate: json["rate"]?.toDouble(),
    minerFee: json["minerFee"]?.toDouble(),
    min: json["min"]?.toDouble(),
    max: json["max"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "rate": rate,
    "minerFee": minerFee,
    "min": min,
    "max": max,
  };
}
