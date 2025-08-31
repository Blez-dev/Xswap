import 'package:Xswap/controllers/swap_controller.dart';
import 'package:Xswap/controllers/swap_market_controller.dart';
import 'package:Xswap/model/swap_pair_data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



class SwapPairDataController extends GetxController{

  SwapController swapController =Get.find<SwapController>();
  SwapMarketController swapMarketController= Get.find<SwapMarketController>();



  var min = 0.0.obs; // reactive double
  var max = 0.0.obs; // reactive double
  var rate= 0.0.obs;



  RxList<SwapPairData> coinPairData = <SwapPairData>[].obs;


  @override
  void onInit(){
    super.onInit();
    fetchCoinsPairData();
  }

  void fetchCoinsPairData() async{
    var request = http.Request(
        'GET',
        Uri.parse('https://api.changenow.io/v1/market-info/fixed-rate/f9c67075d6649de45ed4f8f0c000e11b39321cc80b56bbc880b5e86d990758f0')
    );

    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {
      String result =await response.stream.bytesToString();
      coinPairData.value=swapPairDataFromJson(result);


    getTickerData();


    }
    else {
      print(response.reasonPhrase);
    }




  }

  void getTickerData(){
    final pair = coinPairData.value.firstWhere(
          (item) =>
      item.from == swapMarketController.coinsAvailable[int.parse(swapController.sendCoin.value)].ticker &&
          item.to == swapMarketController.coinsAvailable[int.parse(swapController.receiveCoin.value)].ticker,
      orElse: () => SwapPairData(
        from: "",
        to: "",
        rate: 0.00,
        minerFee: 0.00,
        min: 0.00,
        max: 0.00,
      ),
    );


    min.value=pair.min;
    max.value=pair.max;
    rate.value=pair.rate;
  }



}