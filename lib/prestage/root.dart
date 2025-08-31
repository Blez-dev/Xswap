import 'package:Xswap/controllers/auth_controller.dart';
import 'package:Xswap/mainstage/homepage.dart';
import 'package:Xswap/prestage/login.dart';
import 'package:Xswap/prestage/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Root extends StatelessWidget {
   Root({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      final user = authController.auth.currentUser;
      if (authController.isFirstTime) return OnboardingScreen();
      if (user == null) return Login();
      return Homepage();
    });
  }
  }

