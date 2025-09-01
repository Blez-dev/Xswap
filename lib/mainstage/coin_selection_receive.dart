import 'package:Xswap/controllers/swap_pair_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Xswap/controllers/swap_controller.dart';
import 'package:Xswap/mainstage/homepage.dart';
import 'package:Xswap/mainstage/swap_page.dart';

import '../controllers/coin_market_controller.dart';
import '../controllers/swap_market_controller.dart';

class CoinSelectionReceive extends StatelessWidget {
  CoinSelectionReceive({super.key});

  SwapController swapController = Get.find<SwapController>();
  CoinsMarketController coinsMarketController=Get.find<CoinsMarketController>();
  SwapMarketController swapMarketController= Get.find<SwapMarketController>();
  SwapPairDataController swapPairDataController= Get.find<SwapPairDataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Select Currency"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: swapMarketController.coinsAvailable.length,
        itemBuilder: (context, index) {
          final coin = swapMarketController.coinsAvailable[index];
          return ListTile(
            leading: SvgPicture.network(coin.image,width: 40,height: 40,placeholderBuilder: (context)=> CircularProgressIndicator(color: Colors.black,),),

            title: Text(coin.ticker.toUpperCase()),
            subtitle: Text(coin.name),
            onTap: () {
              if (index == int.parse(swapController.sendCoin.value)) {
                Get.snackbar(
                  "Error",
                  "",
                  backgroundColor: Colors.black,
                  snackPosition: SnackPosition.BOTTOM,
                  titleText: Text(
                    "Cant select same Currency pair",
                    style: const TextStyle(color: Colors.white),
                  ),
                  messageText: Text(
                    "Kindly pick another",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } else {
                swapPairDataController.fetchCoinsPairData();
                swapController.updateReceiveCoin(index);

                Get.offAll(() => Homepage());
              }
            },
          );
        },
      ),
    );
  }
}
