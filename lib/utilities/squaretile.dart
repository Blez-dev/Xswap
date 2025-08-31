import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Squaretile extends StatelessWidget {
  const Squaretile({super.key,required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      padding: EdgeInsets.all(1),

      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),

        color: Colors.grey[200],
      ),
      child: Image.asset(imagePath),

    );
  }
}
