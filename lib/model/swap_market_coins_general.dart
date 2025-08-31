// To parse this JSON data, do
//
//     final swapMarketData = swapMarketDataFromJson(jsonString);

import 'dart:convert';

List<SwapMarketData> swapMarketDataFromJson(String str) => List<SwapMarketData>.from(json.decode(str).map((x) => SwapMarketData.fromJson(x)));

String swapMarketDataToJson(List<SwapMarketData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SwapMarketData {
  String ticker;
  String name;
  String image;
  bool hasExternalId;
  bool isExtraIdSupported;
  bool isFiat;
  bool featured;
  bool isStable;
  bool supportsFixedRate;

  SwapMarketData({
    required this.ticker,
    required this.name,
    required this.image,
    required this.hasExternalId,
    required this.isExtraIdSupported,
    required this.isFiat,
    required this.featured,
    required this.isStable,
    required this.supportsFixedRate,
  });

  factory SwapMarketData.fromJson(Map<String, dynamic> json) => SwapMarketData(
    ticker: json["ticker"],
    name: json["name"],
    image: json["image"],
    hasExternalId: json["hasExternalId"],
    isExtraIdSupported: json["isExtraIdSupported"],
    isFiat: json["isFiat"],
    featured: json["featured"],
    isStable: json["isStable"],
    supportsFixedRate: json["supportsFixedRate"],
  );

  Map<String, dynamic> toJson() => {
    "ticker": ticker,
    "name": name,
    "image": image,
    "hasExternalId": hasExternalId,
    "isExtraIdSupported": isExtraIdSupported,
    "isFiat": isFiat,
    "featured": featured,
    "isStable": isStable,
    "supportsFixedRate": supportsFixedRate,
  };
}
