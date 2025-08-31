import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Xswap/prestage/login.dart';

class ResetSuccessful extends StatefulWidget {
  const ResetSuccessful({super.key});

  @override
  State<ResetSuccessful> createState() => _ResetSuccessfulState();
}

class _ResetSuccessfulState extends State<ResetSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 180),
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 130,
                ),
                Text(
                  "Reset Link Sent!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Reset Link has been sent successfully to your email.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                  ),
                ),
                SizedBox(height: 40),


                ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => Login());
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(200, 50),
                    elevation: 13,
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text("Back to Login Page"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
