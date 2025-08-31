import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Xswap/controllers/coin_market_controller.dart';
import 'package:intl/intl.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final CoinsMarketController coinsMarketController =
      Get.find<CoinsMarketController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto Market"),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 30, color: Colors.black),
      ),
      backgroundColor: Colors.grey[600],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "No",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Spacer(flex: 1),
                    Text(
                      "Coin & Market Cap ",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Spacer(flex: 3),
                    Text(
                      "Price",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Spacer(flex: 1),
                    Text(
                      "24h%",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  return coinsMarketController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        )
                      : ListView.builder(
                          itemCount: 100,
                          itemBuilder: (context, index) {
                            final priceChange =
                                coinsMarketController
                                    .coins[index]
                                    .priceChangePercentage24H ??
                                0;
                            final formattedPriceChange =
                                '${priceChange >= 0 ? '+' : ''}${priceChange.toStringAsFixed(2)}%';
                            final price =
                                coinsMarketController.coins[index].currentPrice;
                            final formattedPrice = NumberFormat.currency(
                              symbol: '\$',
                              decimalDigits: 2,
                            ).format(price);
                            final marketCap =
                                coinsMarketController.coins[index].marketCap;

                            return Container(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                                left: 4,
                                right: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                    ),
                                  ),
                                  const SizedBox(width: 45),
                                  SizedBox(
                                    width: 20,
                                    height: 50,
                                    child: Image.network(
                                      coinsMarketController.coins[index].image,
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        coinsMarketController
                                            .coins[index]
                                            .symbol
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        coinsMarketController.formatMarketCap(
                                          marketCap,
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    formattedPrice,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    formattedPriceChange,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: (priceChange) >= 0
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
