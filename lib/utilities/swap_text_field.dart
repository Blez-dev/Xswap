import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:Xswap/mainstage/coin_selection_send.dart';

class SwapTextField extends StatelessWidget {
  final String selected;
  final String labelText;
  final String hintText;
  final controller;

  const SwapTextField({
    super.key,
    required this.selected,
    required this.labelText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20,
        ),
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              style: BorderStyle.solid,
              color: Colors.black,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(style: BorderStyle.solid, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.grey[100],
          filled: true,
          suffixIcon: Obx(
            () => InkWell(
              onTap: () {
                // Handle tap
                Get.off(() => CoinSelectionPageSend());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                    left: BorderSide(
                      color: Colors.grey,
                      width: 4, // thickness
                    ),
                  ),
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 6),
                    Text(
                      selected,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_drop_down, size: 25),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
