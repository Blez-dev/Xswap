import 'dart:ffi';

import 'package:Xswap/controllers/swap_controller.dart';
import 'package:Xswap/model/swap_market_coins_general.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SwapMarketController extends GetxController {
  SwapController swapController=Get.find<SwapController>();

  RxList<SwapMarketData> coinsAvailable = <SwapMarketData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoins();
  }

  Future<void> fetchCoins() async {
    try {
      var request = http.Request(
        'GET',
        Uri.parse('https://api.changenow.io/v1/currencies?active=true&fixedRate=true'),
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Convert the stream to a string
        String responseBody = await response.stream.bytesToString();

        // Parse JSON into list of SwapMarketData
        coinsAvailable.value = swapMarketDataFromJson(responseBody);




      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}
