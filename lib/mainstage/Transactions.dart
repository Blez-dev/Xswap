import 'package:Xswap/controllers/navigation_controller.dart';
import 'package:Xswap/mainstage/homepage.dart';
import 'package:Xswap/mainstage/swap_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  CustomNavigationController customNavigationController =
      Get.find<CustomNavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 170, color: Colors.grey[800]),
                Text(
                  "You have not made any transactions yet. Tap the button to make a swap.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    Get.off(() => Homepage());
                    customNavigationController.changeIndex(0);
                  },

                  style: ElevatedButton.styleFrom(
                    elevation: 13,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(250, 50),
                  ),
                  child: Text("Make A Swap"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
