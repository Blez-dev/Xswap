import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/auth_controller.dart';

class CircularBar extends StatefulWidget {
  const CircularBar({super.key});

  @override
  State<CircularBar> createState() => _CircularBarState();
}

class _CircularBarState extends State<CircularBar> {



  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    // Delay briefly so the splash shows, then call controller to decide navigation
    Future.delayed(const Duration(milliseconds: 500), () {
      authController.initialScreen(authController.auth.currentUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              value: 0.7,
              strokeWidth: 6,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),


            ),
          ),
        ),
    );
  }
}
