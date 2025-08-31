import 'package:Xswap/mainstage/Transactions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Xswap/controllers/navigation_controller.dart';
import 'package:Xswap/mainstage/market_page.dart';
import 'package:Xswap/mainstage/profile_page.dart';
import 'package:Xswap/mainstage/swap_page.dart';
import 'package:Xswap/utilities/bottom_navigation_bar.dart';

class Homepage extends StatelessWidget {
   Homepage({super.key});
   CustomNavigationController customNavigationController =Get.find<CustomNavigationController>();
  final List<Widget> pages= [
   SwapPage(),MarketPage(),Transactions(),ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
          ()=>IndexedStack(
            index: customNavigationController.currentIndex.value,
            children: pages,
          )
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
