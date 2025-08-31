import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerButton extends StatelessWidget {
  final IconData leadingIcon;     // first icon
  final String text;              // button text
  final IconData? trailingIcon;    // last icon
  final VoidCallback onTap;      // optional click action
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  const ContainerButton({
    super.key,
    required this.leadingIcon,
    required this.text,
     this.trailingIcon,
    required this.onTap,
    required this.backgroundColor, // default color
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12),
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(leadingIcon, color: iconColor, size: 30),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(trailingIcon, color: iconColor),
            ],
          ),
        ),
      ),
    );
  }
}
