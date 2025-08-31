import 'package:Xswap/controllers/swap_market_controller.dart';
import 'package:Xswap/controllers/swap_pair_data_controller.dart';
import 'package:Xswap/mainstage/address_input_page.dart';
import 'package:Xswap/mainstage/homepage.dart';
import 'package:Xswap/prestage/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:Xswap/controllers/auth_controller.dart';
import 'package:Xswap/controllers/coin_market_controller.dart';
import 'package:Xswap/controllers/navigation_controller.dart';
import 'package:Xswap/controllers/swap_controller.dart';
import 'package:Xswap/controllers/textfield_Controller.dart';
import 'package:Xswap/prestage/onboarding_screen.dart';
import 'package:Xswap/prestage/signup.dart';
import 'package:Xswap/utilities/circular_bar.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  await GetStorage.init();
  //await GetStorage().erase();
  Get.put(AuthController());
  Get.put(SwapController());
  Get.put(CustomNavigationController());
  Get.put(CoinsMarketController());
  Get.put(FieldController());
  Get.put(SwapMarketController());
  Get.put(SwapPairDataController());
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      FlutterNativeSplash.remove();
      AuthController.authController.initialScreen(AuthController.authController.auth.currentUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: Homepage());
  }
}
