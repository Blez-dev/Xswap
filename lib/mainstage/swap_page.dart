import 'package:Xswap/controllers/exchange_conversion_amount.dart';
import 'package:Xswap/controllers/swap_market_controller.dart';
import 'package:Xswap/controllers/swap_pair_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Xswap/controllers/navigation_controller.dart';
import 'package:Xswap/controllers/swap_controller.dart';
import 'package:Xswap/mainstage/address_input_page.dart';
import 'package:Xswap/mainstage/coin_selection_receive.dart';
import 'package:Xswap/mainstage/coin_selection_send.dart';
import 'package:Xswap/mainstage/market_page.dart';
import 'package:Xswap/mainstage/profile_page.dart';
import 'package:Xswap/utilities/CustomTextField.dart';
import 'package:Xswap/utilities/bottom_navigation_bar.dart';
import 'package:Xswap/utilities/swap_text_field.dart';


import '../controllers/coin_market_controller.dart';

class SwapPage extends StatefulWidget {
  SwapPage({super.key});

  @override
  State<SwapPage> createState() => _SwapPageState();
}

class _SwapPageState extends State<SwapPage> {
  CustomNavigationController navigationController =
      Get.find<CustomNavigationController>();
  SwapController swapController = Get.find<SwapController>();
  CoinsMarketController coinsMarketController =
      Get.find<CoinsMarketController>();
  SwapMarketController swapMarketController = Get.find<SwapMarketController>();
  SwapPairDataController swapPairDataController=Get.find<SwapPairDataController>();
  ExchangeConversionAmountController exchangeConversionAmountController= Get.find<ExchangeConversionAmountController>();
  final sendController = TextEditingController();
  final receiveController = TextEditingController();
  final addressController = TextEditingController();
  final List<Widget> pages = [SwapPage(), MarketPage(), ProfilePage()];


  @override
  void initState() {

    super.initState();
    sendController.addListener((){
      final inputAmount=sendController.text;
      if(inputAmount.isNotEmpty){
        exchangeConversionAmountController.fetchConversionAmount(inputAmount,receiveController);
      }else{
        receiveController.text = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: [],
        title: Text("X-SWAP"),
        centerTitle: true,
        toolbarHeight: 60,
        titleTextStyle: TextStyle(fontSize: 40, color: Colors.black),
        backgroundColor: Colors.white,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "FLASH CRYPTOCURRENCY \nEXCHANGE",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: sendController,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter amount to send",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.grey[100],
                        filled: true,
                        suffixIcon: Obx(() {
                          if (coinsMarketController.coins.isEmpty) {
                            return SizedBox();
                          }
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => CoinSelectionPageSend());
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                swapMarketController.coinsAvailable.isNotEmpty
                                    ? SvgPicture.network(
                                  swapMarketController.coinsAvailable[int.parse(
                                    swapController.sendCoin.toString(),
                                  )].image,
                                  width: 25,
                                )
                                    : SizedBox.shrink(),

                                SizedBox(width: 7),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    Text(

                                      swapMarketController.coinsAvailable.isNotEmpty?
                                      swapMarketController
                                          .coinsAvailable[int.parse(
                                        swapController.sendCoin.toString(),
                                      )]
                                          .ticker
                                          .toUpperCase(): ""
                                    ),


                                  ],
                                ),
                                Icon(Icons.arrow_drop_down, size: 25),
                                SizedBox(width: 10),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [


                            Obx(() {
                              final coins = swapMarketController.coinsAvailable;
                              final hasData = coins.isNotEmpty && int.parse(swapController.sendCoin.value) < coins.length;
                              final ticker = hasData ? coins[int.parse(swapController.sendCoin.value)].ticker.toUpperCase() : "";
                              final minValue = swapPairDataController.min.toStringAsFixed(4);
                              exchangeConversionAmountController.minValueAmount.value=minValue;
                              return Text(
                                "Min: $minValue $ticker",
                                style: TextStyle(color: Colors.red),
                              );
                            }),
                            Obx(() {
                              final coins = swapMarketController.coinsAvailable;
                              final hasData = coins.isNotEmpty && int.parse(swapController.sendCoin.value) < coins.length;
                              final ticker = hasData ? coins[int.parse(swapController.sendCoin.value)].ticker.toUpperCase() : "";
                              final maxValue = swapPairDataController.max.toStringAsFixed(4);
                              exchangeConversionAmountController.maxValueAmount.value=maxValue;
                              return Text(
                                "Max: $maxValue $ticker",
                                style: TextStyle(color: Colors.red),
                              );
                            }),




                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            swapController.swapCoinText();
                            swapPairDataController.getTickerData();
                          },
                          icon: Icon(Icons.swap_vert_outlined, size: 45),
                        ),
                      ],
                    ),
                  ), // The Swap Icon

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: receiveController,
                      readOnly: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Input amount to receive",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.grey[100],
                        filled: true,
                        suffixIcon: Obx(() {
                          if (coinsMarketController.coins.isEmpty)
                            return SizedBox();

                          return GestureDetector(
                            onTap: () {
                              Get.to(() => CoinSelectionReceive());
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                swapMarketController.coinsAvailable.isNotEmpty?
                                SvgPicture.network(
                                  swapMarketController
                                      .coinsAvailable[int.parse(
                                    swapController.receiveCoin.toString(),
                                  )]
                                      .image,
                                  width: 25,
                                  height: 25,

                                ): SizedBox.shrink(),
                                SizedBox(width: 7),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      swapMarketController.coinsAvailable.isNotEmpty ? swapMarketController.coinsAvailable[int.parse(swapController.receiveCoin.toString(),)].ticker.toUpperCase()
                                          : "",
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_drop_down, size: 25),
                                SizedBox(width: 10),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx((){
                          final coins = swapMarketController.coinsAvailable;
                          final hasData = coins.isNotEmpty && int.parse(swapController.sendCoin.value) < coins.length;
                          final ticker = hasData ? coins[int.parse(swapController.sendCoin.value)].ticker.toUpperCase() : "";
                          final receiveTicker = hasData ? coins[int.parse(swapController.receiveCoin.value)].ticker.toUpperCase() : "";
                          final rate= swapPairDataController.rate.value.toStringAsFixed(4);

                          return Text("1 $ticker ~ $rate $receiveTicker" );

                        })

                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Destination Address"),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: addressController,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),

                      decoration: InputDecoration(
                        hintText: "Your Bitcoin Address",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      //Get.to(() => AddressInputPage());
                      Get.snackbar("Feature not implemented yet!", "Coming in next release");
                    },

                    style: ElevatedButton.styleFrom(
                      elevation: 13,
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: Size(250, 50),
                    ),
                    child: Text("Exchange Now", style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
