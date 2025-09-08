import 'package:Xswap/controllers/swap_controller.dart';
import 'package:Xswap/controllers/swap_market_controller.dart';
import 'package:Xswap/model/exchange_conversion_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ExchangeConversionAmountController extends GetxController{
  SwapMarketController swapMarketController = Get.find<SwapMarketController>();
  SwapController swapController = Get.find<SwapController>();
  var estimatedAmount= 0.0.obs;
  var networkFee= 0.0.obs;
  var validUntil = DateTime.now().obs;
  var minValueAmount="".obs;
  var maxValueAmount="".obs;
  var hasError= false.obs;



  var conversionAmount = ExchangeConversion(
    estimatedAmount: 0.0,
    networkFee: 0.0,
    transactionSpeedForecast: '',
    warningMessage: null,
    rateId: '',
    validUntil: DateTime.now(),
  ).obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //fetchConversionAmount();
  }


  void fetchConversionAmount(String sendAmount,TextEditingController receiveController) async {
    final fromTicker = swapMarketController.coinsAvailable[int.parse(swapController.sendCoin.value)].ticker.toLowerCase();
    final toTicker = swapMarketController.coinsAvailable[int.parse(swapController.receiveCoin.value)].ticker.toLowerCase();



        var request = http.Request('GET',
            Uri.parse(
                'https://api.changenow.io/v1/exchange-amount/fixed-rate/$sendAmount/${fromTicker}_$toTicker?api_key=f9c67075d6649de45ed4f8f0c000e11b39321cc80b56bbc880b5e86d990758f0&useRateId=true'));

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          String result = await response.stream.bytesToString();
          conversionAmount.value = exchangeConversionFromJson(result);

          // Update the receive field
          receiveController.text = conversionAmount.value.estimatedAmount.toStringAsFixed(6);
          print(receiveController.text);
        } else {
          print('Error: ${response.statusCode} - ${response.reasonPhrase}');
          receiveController.text = '';
        }



  }





}