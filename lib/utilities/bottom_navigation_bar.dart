import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Xswap/controllers/navigation_controller.dart';
import 'package:Xswap/mainstage/market_page.dart';
import 'package:Xswap/mainstage/profile_page.dart';
import 'package:Xswap/mainstage/swap_page.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({super.key});

  CustomNavigationController customNavigationController = Get.find<CustomNavigationController>();


  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          BottomNavigationBar(
            currentIndex: customNavigationController.currentIndex.value,
            onTap: (index) {

              customNavigationController.changeIndex(index);
            },
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            //elevation: 50,
            selectedItemColor: Colors.black,
            selectedFontSize: 15,
            unselectedFontSize: 12,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),

            items: [
              BottomNavigationBarItem(icon: Icon(Icons.sync), label: "Swap"),
              BottomNavigationBarItem(
                icon: Icon(Icons.trending_up_outlined),
                label: "Market",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Transactions"),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: "Profile",
              ),
            ],
          ),

      );



  }
}
