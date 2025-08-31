import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:Xswap/controllers/auth_controller.dart';
import 'package:Xswap/utilities/CustomTextField.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailController = TextEditingController();

  //void _validation(){
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 140),
                    Icon(Icons.lock_reset, size: 150),
                    Text(
                      "FORGET  PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),

                      child: Text(
                        "Provide your account\"s email for which you want to reset your password",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    SizedBox(height: 40),
                    Customtextfield(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false,
                      label: "Email",
                    ),
                    SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () {
                        AuthController.authController.reset(
                          emailController.text.trim(),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: Size(250, 50),
                        elevation: 13,
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: Text("Reset Password"),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (AuthController.authController.isLoading.value) {
                return Positioned.fill(
                  child: Container(
                    //color: Colors.black.withValues(alpha: 0.3),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
