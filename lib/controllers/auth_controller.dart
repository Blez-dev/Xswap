import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:Xswap/mainstage/homepage.dart';
import 'package:Xswap/prestage/login.dart';
import 'package:Xswap/mainstage/swap_page.dart';
import 'package:Xswap/prestage/onboarding_screen.dart';
import 'package:Xswap/prestage/reset_password.dart';
import 'package:Xswap/prestage/reset_successful.dart';
import 'package:Xswap/prestage/signup.dart';
import 'package:Xswap/utilities/circular_bar.dart';

class AuthController extends GetxController {
  static AuthController authController = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = GetStorage();
  final RxBool _isFirstTime = true.obs;
  final RxBool _isLoggedIn = false.obs;
  final RxBool _beenToHomepage = false.obs;

  bool get isFirstTime => _isFirstTime.value;

  bool get isLoggedIn => _isLoggedIn.value;
  RxBool isLoading = false.obs;
  var signedUpEmail = "".obs;
  var username = "null".obs;
  var email = "null".obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  @override
  void onReady() {
    super.onReady();

    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, initialScreen);
  }

  void initialScreen(User? user) {
    if (user == null && isFirstTime == true) {
      Get.off(
        () => const OnboardingScreen(),
            //() =>  SwapPage(),
        curve: Curves.easeInOutCubic,
        //transition: Transition.fadeIn,
      );
    } else if (user == null && isFirstTime == false) {
      Get.offAll(
        () => Login(),
        curve: Curves.easeInOutCubic,
        //transition: Transition.zoom,
      );
    } else if (user != null &&
        isFirstTime == false &&
        _beenToHomepage.value == false) {
      Get.offAll(
        () => Login(),
        curve: Curves.easeInOutCubic,
        //transition: Transition.zoom,
      );
    } else if (user != null && _beenToHomepage.value == true) {
      username.value = storage.read("username");
      email.value = storage.read("email");
      Get.offAll(
        () => Homepage(),
        curve: Curves.easeInOutCubic,
        //transition: Transition.zoom,
      );
    }
  }

  void _loadFromStorage() {
    _isFirstTime.value = storage.read("isFirstTime") ?? true;
    _isLoggedIn.value = storage.read("isLoggedIn") ?? false;
    _beenToHomepage.value = storage.read("beenToHomepage") ?? false;

  }

  void setFirstTimeDone() {
    _isFirstTime.value = false;
    storage.write("isFirstTime", false);
  }

  Future<void> register(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _showError("Account Creation Successful", "");
      isLoading.value = false;
      signedUpEmail.value = email;
      Get.offAll(() => Login());
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      _showError("Account creation failed", "Kindly enter in correct details");
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      _showError("Login Successful", "");
      loginSuccessActions();
      isLoading.value = false;
      Get.offAll(() => Homepage());

    } on FirebaseAuthException catch (e) {
      isLoading.value = false;

      _showError(
        "Login failed!",
        "An unexpected error occurred.please try again.",
      );
    }
  }

  Future<void> reset(String email) async {
    try {
      isLoading.value = true;
      await auth.sendPasswordResetEmail(email: email);
      isLoading.value = false;
      Get.off(() => ResetSuccessful());
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      _showError("Reset Failed", e.message.toString());
    }
  }

  void loginSuccessActions() {
    _isLoggedIn.value = true;
    _beenToHomepage.value == true;
    storage.write("isLoggedIn", true);
    storage.write("beenToHomepage", true);
  }

  void logout() async {
    await auth.signOut();
    _isLoggedIn.value = false;
    storage.write("isLoggedIn", false);
    storage.write("beenToHomepage", false);
    storage.remove("username");
    storage.remove("email");
  }

  void _showError(String title, String message) {
    Get.snackbar(
      "Error",
      "",
      backgroundColor: Colors.black,
      duration: Duration(milliseconds: 800),
      snackPosition: SnackPosition.TOP,
      titleText: Text(title, style: const TextStyle(color: Colors.white)),
      messageText: Text(message, style: const TextStyle(color: Colors.white)),
    );
  }

  bool isValidEmail(String email) {
    // Simple regex for common email formats
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email.trim());
  }

  bool isValidPassword(String password) {
    // Firebase minimum password length requirement is 6
    return password.trim().length >= 6;
  }
}
