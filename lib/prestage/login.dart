import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Xswap/controllers/auth_controller.dart';
import 'package:Xswap/controllers/textfield_Controller.dart';
import 'package:Xswap/prestage/reset_password.dart';
import 'package:Xswap/prestage/signup.dart';
import 'package:Xswap/utilities/CustomTextField.dart';
import 'package:Xswap/utilities/squaretile.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController emailController = TextEditingController(
    text: AuthController.authController.signedUpEmail.value,
  ); // 👈 pre-fill email

  final passwordController = TextEditingController();
  FieldController fieldController = Get.find<FieldController>();

  void _validation() {
    if (AuthController.authController.isValidEmail(emailController.text.trim(),) && AuthController.authController.isValidPassword(passwordController.text.trim(),)) {
      AuthController.authController.login(emailController.text.trim(), passwordController.text.trim(),);
      String? username= AuthController.authController.storage.read(emailController.text.trim());
      if(username!=null){

        AuthController.authController.storage.write("username", username);
        AuthController.authController.storage.write("email", emailController.text.trim());
        AuthController.authController.username.value = AuthController.authController.storage.read("username");
        AuthController.authController.email.value = AuthController.authController.storage.read("email");


      }else{
        AuthController.authController.username.value="null";
      };
    } else {
      if (!AuthController.authController.isValidEmail(
        emailController.text.trim(),
      )) {
        Get.snackbar(
          "Error",
          "Unexpected error with email or password",
          backgroundColor: Colors.black,
          snackPosition: SnackPosition.TOP,
          duration: Duration(milliseconds: 800),
          titleText: const Text("Error", style: TextStyle(color: Colors.white)),
          messageText: const Text(
            "unexpected error with email or password",
            style: TextStyle(color: Colors.white),
          ),
        );
      } else if (!AuthController.authController.isValidPassword(
        passwordController.text.trim(),
      )) {
        Get.snackbar(
          "Error",
          "Unexpected error with Password",
          backgroundColor: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text("Error", style: TextStyle(color: Colors.white)),
          messageText: const Text(
            "Password must be at least 6 characters",
            style: TextStyle(color: Colors.white),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(
          children: [
            /// 🔹 Login page content
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      "assets/images/security.png",
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Welcome Back!!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Customtextfield(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false,
                      label: "Email",
                    ),
                    const SizedBox(height: 15),
                    Obx(
                      () => Customtextfield(
                        controller: passwordController,
                        suffixIcon: IconButton(
                          onPressed: () {
                            fieldController.changeObscureState();
                          },
                          icon: Icon(
                            fieldController.obscureText.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        hintText: "Password",
                        obscureText: fieldController.obscureText.value,
                        label: "Password",
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(
                                () => ResetPassword(),
                                curve: Curves.easeInOutCubic,
                                transition: Transition.zoom,
                              );
                            },
                            child: const Text("Forgot Password?"),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _validation,
                      style: ElevatedButton.styleFrom(
                        elevation: 13,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(250, 50),
                      ),
                      child: const Text("Login Here"),
                    ),
                    const SizedBox(height: 13),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey[700],
                              thickness: 0.5,
                            ),
                          ),
                          const Text("Or Continue with"),
                          Expanded(
                            child: Divider(
                              color: Colors.grey[700],
                              thickness: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Squaretile(imagePath: "assets/images/gg.png"),
                        SizedBox(width: 20),
                        Squaretile(imagePath: "assets/images/fb.png"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Not a member?"),
                        TextButton(
                          onPressed: () {
                            Get.to(
                              () => SignUp(),
                              curve: Curves.easeInOutCubic,
                              transition: Transition.zoom,
                            );
                          },
                          child: const Text("Register Now"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// 🔹 Loading overlay with blur
            Obx(() {
              if (AuthController.authController.isLoading.value) {
                return Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.3),
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      ),
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
