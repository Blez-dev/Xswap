import 'dart:convert';

List<CoinsMarketData> coinsMarketDataFromJson(String str) =>
    List<CoinsMarketData>.from(json.decode(str).map((x) => CoinsMarketData.fromJson(x)));

String coinsMarketDataToJson(List<CoinsMarketData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoinsMarketData {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  int? marketCap;
  int? marketCapRank;
  int? fullyDilutedValuation;
  double? totalVolume;
  double? high24H;
  double? low24H;
  double? priceChange24H;
  double? priceChangePercentage24H;
  double? marketCapChange24H;
  double? marketCapChangePercentage24H;
  double? circulatingSupply;
  double? totalSupply;
  double? maxSupply;
  double ath;
  double athChangePercentage;
  DateTime athDate;
  double atl;
  double atlChangePercentage;
  DateTime atlDate;
  Roi? roi;
  DateTime lastUpdated;

  CoinsMarketData({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.fullyDilutedValuation,
    this.totalVolume,
    this.high24H,
    this.low24H,
    this.priceChange24H,
    this.priceChangePercentage24H,
    this.marketCapChange24H,
    this.marketCapChangePercentage24H,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    this.roi,
    required this.lastUpdated,
  });

  factory CoinsMarketData.fromJson(Map<String, dynamic> json) => CoinsMarketData(
    id: json["id"],
    symbol: json["symbol"],
    name: json["name"],
    image: json["image"],
    currentPrice: (json["current_price"] ?? 0).toDouble(),
    marketCap: json["market_cap"],
    marketCapRank: json["market_cap_rank"],
    fullyDilutedValuation: json["fully_diluted_valuation"],
    totalVolume: json["total_volume"]?.toDouble(),
    high24H: json["high_24h"]?.toDouble(),
    low24H: json["low_24h"]?.toDouble(),
    priceChange24H: json["price_change_24h"]?.toDouble(),
    priceChangePercentage24H: json["price_change_percentage_24h"]?.toDouble(),
    marketCapChange24H: json["market_cap_change_24h"]?.toDouble(),
    marketCapChangePercentage24H: json["market_cap_change_percentage_24h"]?.toDouble(),
    circulatingSupply: json["circulating_supply"]?.toDouble(),
    totalSupply: json["total_supply"]?.toDouble(),
    maxSupply: json["max_supply"]?.toDouble(),
    ath: json["ath"]?.toDouble() ?? 0,
    athChangePercentage: json["ath_change_percentage"]?.toDouble() ?? 0,
    athDate: DateTime.parse(json["ath_date"]),
    atl: json["atl"]?.toDouble() ?? 0,
    atlChangePercentage: json["atl_change_percentage"]?.toDouble() ?? 0,
    atlDate: DateTime.parse(json["atl_date"]),
    roi: json["roi"] == null ? null : Roi.fromJson(json["roi"]),
    lastUpdated: DateTime.parse(json["last_updated"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "symbol": symbol,
    "name": name,
    "image": image,
    "current_price": currentPrice,
    "market_cap": marketCap,
    "market_cap_rank": marketCapRank,
    "fully_diluted_valuation": fullyDilutedValuation,
    "total_volume": totalVolume,
    "high_24h": high24H,
    "low_24h": low24H,
    "price_change_24h": priceChange24H,
    "price_change_percentage_24h": priceChangePercentage24H,
    "market_cap_change_24h": marketCapChange24H,
    "market_cap_change_percentage_24h": marketCapChangePercentage24H,
    "circulating_supply": circulatingSupply,
    "total_supply": totalSupply,
    "max_supply": maxSupply,
    "ath": ath,
    "ath_change_percentage": athChangePercentage,
    "ath_date": athDate.toIso8601String(),
    "atl": atl,
    "atl_change_percentage": atlChangePercentage,
    "atl_date": atlDate.toIso8601String(),
    "roi": roi?.toJson(),
    "last_updated": lastUpdated.toIso8601String(),
  };
}

class Roi {
  double? times;
  Currency? currency;
  double? percentage;

  Roi({this.times, this.currency, this.percentage});

  factory Roi.fromJson(Map<String, dynamic> json) => Roi(
    times: json["times"]?.toDouble(),
    currency: currencyValues.map[json["currency"]],
    percentage: json["percentage"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "times": times,
    "currency": currencyValues.reverse[currency],
    "percentage": percentage,
  };
}

enum Currency { BTC, ETH, USD }

final currencyValues = EnumValues({
  "btc": Currency.BTC,
  "eth": Currency.ETH,
  "usd": Currency.USD
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
