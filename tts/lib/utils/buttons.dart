import 'package:flutter/material.dart';

class Buttons {
  double height = 0.0;
  double width = 0.0;
  Color primaryBoxColor = Colors.black;
  Color primaryTextColor = Colors.white;
  String title = "";
  double borderRadius = 0.0;
  double fontSize = 0.0;

  Buttons({
    required this.height,
    required this.width,
    required this.primaryBoxColor,
    required this.borderRadius,
    required this.primaryTextColor,
    required this.title,
    required this.fontSize,
  });

  button1() {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: primaryBoxColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            borderRadius,
          ),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: primaryTextColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  button2() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: primaryBoxColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            borderRadius,
          ),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: primaryTextColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
