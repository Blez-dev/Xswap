import 'package:Xswap/mainstage/profile_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Xswap/controllers/auth_controller.dart';
import 'package:Xswap/prestage/login.dart';
import 'package:Xswap/utilities/circular_bar.dart';

import 'package:Xswap/utilities/container_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthController authController = Get.find<AuthController>();

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade300,

          title: Text("Log Out", style: TextStyle(fontSize: 35)),
          content: Text(
            "Are you sure you want to Log out?",
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                authController.logout();
                navigator?.pop(context);
                Get.offAll(() => Login());
              },
              child: Text("YES"),
            ),

            TextButton(
              onPressed: () {
                navigator?.pop(context);
              },
              child: Text("NO"),
            ),
          ],
        );
      },
    );
  }

  Future _showAbout() {
    return showDialog(
      context: context,
      builder: (context) => AboutDialog(
        //applicationIcon: FlutterLogo(),
        applicationLegalese: "Blezant @2025",
        applicationName: "X-SWAP",

        applicationVersion: "version 1.0.0",
        //children: [Text("App created solely by Blezant")],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Profile "), backgroundColor: Colors.white),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/profile1.png",width: 180,height: 180,),
                  SizedBox(height: 10,),
                  ContainerButton(
                    leadingIcon: Icons.account_circle,
                    text: "Profile Details",
                    trailingIcon: Icons.arrow_forward,
                    onTap: () {
                      Get.to(() => ProfileDetailsPage());
                    },
                    backgroundColor: Colors.grey.shade500,
                    iconColor: Colors.black,
                    textColor: Colors.black,
                  ),
                  ContainerButton(
                    leadingIcon: Icons.lock,
                    text: "Change Password",
                    trailingIcon: Icons.arrow_forward,
                    onTap: () {
                      Get.snackbar(
                        "Error",
                        "",
                        backgroundColor: Colors.black,
                        duration: Duration(milliseconds: 800),
                        snackPosition: SnackPosition.TOP,
                        titleText: Text("Feature not Available yet", style: const TextStyle(color: Colors.white)),
                        messageText: Text("Coming in the next release!", style: const TextStyle(color: Colors.white)),
                      );
                    },
                    backgroundColor: Colors.grey.shade500,
                    iconColor: Colors.black,
                    textColor: Colors.black,
                  ),
                  ContainerButton(
                    leadingIcon: Icons.headset_mic_outlined,
                    text: "Contact us",
                    trailingIcon: Icons.arrow_forward,
                    onTap: () {
                      Get.snackbar(
                        "Error",
                        "",
                        backgroundColor: Colors.black,
                        duration: Duration(milliseconds: 800),
                        snackPosition: SnackPosition.TOP,
                        titleText: Text("Feature not Available yet", style: const TextStyle(color: Colors.white)),
                        messageText: Text("Coming in the next release!", style: const TextStyle(color: Colors.white)),
                      );
                    },
          
                    backgroundColor: Colors.grey.shade500,
                    iconColor: Colors.black,
                    textColor: Colors.black,
                  ),
                  ContainerButton(
                    leadingIcon: Icons.article_rounded,
                    text: "About app",
                    trailingIcon: Icons.arrow_forward,
                    onTap: () {
                      _showAbout();
                    },
                    backgroundColor: Colors.grey.shade500,
                    iconColor: Colors.black,
                    textColor: Colors.black,
                  ),
                  ContainerButton(
                    leadingIcon: Icons.logout,
                    text: "Log Out",
          
                    onTap: () {
                      //authController.logout();
                      _showDialog();
                    },
                    backgroundColor: Colors.black,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
