import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customswaptextfield extends StatelessWidget {
  const Customswaptextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
      child: TextField(

      ),

    );
  }
}




/*Padding(
padding: EdgeInsets.all(10),
child: TextField(
style: TextStyle(
fontWeight: FontWeight.bold,
color: Colors.black,
fontSize: 20,
),
keyboardType: TextInputType.number,
controller: _sendController,
decoration: InputDecoration(
labelText: "send",
labelStyle: TextStyle(),
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
width: 2,
),
borderRadius: BorderRadius.circular(12),
),
fillColor: Colors.grey[100],
filled: true,
suffixIcon: Obx(
() => InkWell(
onTap: () {
// Handle tap
Get.to(() => CoinSelectionPageSend());
},
child: Container(
padding: EdgeInsets.symmetric(
horizontal: 20,
vertical: 4,
),
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
swapController.sendCoin.toString(),
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
),*/