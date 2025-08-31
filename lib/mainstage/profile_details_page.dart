import 'package:Xswap/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});


  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();

}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Details"),
        backgroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Image.asset(
                "assets/images/profile1.png",
                width: 180,
                height: 180,
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Username:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10,),
              Obx(() {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    AuthController.authController.username.value,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              }
              ),

              SizedBox(height: 30,),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Email:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10,),
              Obx(() {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    AuthController.authController.email.value,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
