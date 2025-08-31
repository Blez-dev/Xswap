import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:Xswap/model/coin_market_data.dart';
import 'package:intl/intl.dart';

class CoinsMarketController extends GetxController {
  // Observables
  RxList<CoinsMarketData> coins = <CoinsMarketData>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoins();
  }

  // Base URL with API key included
  static const String _baseUrl =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=250&page=1&x_cg_demo_api_key=CG-z6xmBwz4PUa3C1J56zHMwe2X";

  /// Fetch market data for all coins
  Future<void> fetchCoins() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse(_baseUrl);

      final response = await http.get(
        uri,
        headers: {"accept": "application/json"},
      );

      if (response.statusCode == 200) {
        coins.value = coinsMarketDataFromJson(response.body);
      } else {
        errorMessage.value =
            "Failed to load data: ${response.statusCode} ${response.reasonPhrase}";
      }
    } catch (e) {
      errorMessage.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }

  String formatMarketCap(int? value) {
    if (value == null) return "\$0";

    if (value >= 1e12) {
      return "\$${(value / 1e12).toStringAsFixed(2)}T";
    } else if (value >= 1e9) {
      return "\$${(value / 1e9).toStringAsFixed(2)}B";
    } else if (value >= 1e6) {
      return "\$${(value / 1e6).toStringAsFixed(2)}M";
    } else if (value >= 1e3) {
      return "\$${(value / 1e3).toStringAsFixed(2)}K";
    } else {
      return "\$${value.toString()}";
    }
  }
}
