import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {


  final controller;
  final String hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final String label;
  final Widget? suffixIcon;

  const Customtextfield({

    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.prefixIcon,
    required this.label,
    this.suffixIcon

  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefix: prefixIcon, // This allows you to pass text or any widget
          hintText: hintText,
          labelText: label,
          suffixIcon: suffixIcon,
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.grey[600]),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              style: BorderStyle.solid,
              color: Colors.white,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              style: BorderStyle.solid,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );




  }
}
