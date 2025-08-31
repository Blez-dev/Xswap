import 'package:Xswap/controllers/coin_market_controller.dart';
import 'package:Xswap/controllers/swap_market_controller.dart';
import 'package:Xswap/model/coin_market_data.dart';
import 'package:get/get.dart';
import 'package:Xswap/model/coins_model.dart';

class SwapController extends GetxController {

   RxList coins = <CoinsMarketData>[].obs;

  var sendCoin = "0".obs;
  var receiveCoin = "1".obs;


   var holder = ''.obs;

  @override
  void onInit(){
    super.onInit();

  }

  void updateSendCoin(int name) {
    String parsedString= name.toString();
    sendCoin.value = parsedString;
  }

  void updateReceiveCoin(int name) {
    String parsedString= name.toString();
    receiveCoin.value = parsedString;
  }

  void swapCoinText() {
    holder.value = sendCoin.value;
    sendCoin.value = receiveCoin.value;
    receiveCoin.value = holder.value;
  }
}
