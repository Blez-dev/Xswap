import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Xswap/controllers/auth_controller.dart';
import 'package:Xswap/prestage/login.dart';
import 'package:Xswap/utilities/CustomTextField.dart';
import 'package:Xswap/utilities/squaretile.dart';

import '../controllers/textfield_Controller.dart';

class SignUp extends StatefulWidget {
   const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   final usernameSignupController= TextEditingController();

  final emailSignupController= TextEditingController();

   final passwordSignupController= TextEditingController();
   FieldController fieldController = Get.find<FieldController>();


   void _validation() async {
     if(AuthController.authController.isValidEmail(emailSignupController.text.trim())&& AuthController.authController.isValidPassword(passwordSignupController.text.trim())) {
       await AuthController.authController.register(emailSignupController.text.trim(), passwordSignupController.text.trim());
       AuthController.authController.storage.write(emailSignupController.text.trim(), usernameSignupController.text.trim());
     }else if((AuthController.authController.isValidEmail(emailSignupController.text.trim())==false) || AuthController.authController.isValidPassword(passwordSignupController.text.trim())==false) {
       if((AuthController.authController.isValidEmail(emailSignupController.text.trim()))==false){
         Get.snackbar("Error", "Unexpected error with email",
           backgroundColor: Colors.black,
           snackPosition: SnackPosition.BOTTOM,
           titleText: Text("Error", style: const TextStyle(color: Colors.white)),
           messageText: Text("unexpected error with email", style: const TextStyle(color: Colors.white)),
         );

       }else if((AuthController.authController.isValidPassword(passwordSignupController.text.trim()))==false){
         Get.snackbar("Error", "Unexpected error with Password",
           backgroundColor: Colors.black,
           snackPosition: SnackPosition.BOTTOM,
           titleText: Text("Error", style: const TextStyle(color: Colors.white)),
           messageText: Text("Password must be at least 6 characters", style: const TextStyle(color: Colors.white)),
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
                      SingleChildScrollView(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30,),
                            Image.asset("assets/images/signup_page.png",
                              width: 200,
                              height: 170,),
                            SizedBox(height: 20,),
                            Text(
                              "Sign Up Here!!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                              ),
                            ),
                            SizedBox(height: 10,),
                            Customtextfield(
                                controller: usernameSignupController,
                                hintText: "Username",
                                obscureText: false,
                              label: "Username",
                            ),
                            SizedBox(height: 20,),
                            Customtextfield(
                                controller: emailSignupController,
                                hintText: "Email",
                                obscureText: false,
                              label: "Email",

                            ),
                            SizedBox(height: 20,),
                            Obx(
                                  () => Customtextfield(
                                controller: passwordSignupController,
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
                            SizedBox(height: 20,),
                            ElevatedButton(
                                onPressed: () {
                                  if(usernameSignupController.text.isNotEmpty&&passwordSignupController.text.isNotEmpty&&emailSignupController.text.isNotEmpty){
                                    _validation();
                                  }else{
                                    Get.snackbar(
                                      "Error",
                                      "",
                                      backgroundColor: Colors.black,
                                      duration: Duration(milliseconds: 800),
                                      snackPosition: SnackPosition.TOP,
                                      titleText: Text("Required", style: const TextStyle(color: Colors.white)),
                                      messageText: Text("Kindly fill in all fields!", style: const TextStyle(color: Colors.white)),
                                    );
                                  }

                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(250, 50),
                                  elevation: 13,
                                  textStyle: TextStyle(fontSize: 20)

                                ),
                              child: Text("Sign Up"),

                            ),
                            SizedBox(height: 20,),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Expanded(child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  )),
                                  Text("Or Sign Up with"),
                                  Expanded(child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ))
                                ],
                              ),
                            ),
                            SizedBox(height: 50,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Squaretile(imagePath: "assets/images/gg.png"),
                                SizedBox(width: 20,),
                                Squaretile(imagePath: "assets/images/fb.png"),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already a member?"),
                                TextButton(
                                    onPressed: (){
                                      Get.back();
                                    },

                                    style: TextButton.styleFrom(elevation: 100,),
                                  child: Text("Login Here",style: TextStyle(fontWeight: FontWeight.bold),),
                                )
                              ],

                            )
                          ],
                        ),
                      ),
                    ),

                      Obx(() {
                        if (AuthController.authController.isLoading.value) {
                          return Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
                              child: Container(
                                color: Colors.black.withValues(alpha: 0.3),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
    ],
                  )

              ),



    );
  }
}
