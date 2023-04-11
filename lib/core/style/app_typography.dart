import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle headline({Color color = Colors.black}) {
    return TextStyle(
      fontSize: 18.0,
      letterSpacing: 0.64,
      height: 1.4,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle body(
      {Color color = Colors.black,
      double fz = 14.0,
      TextDecoration td = TextDecoration.none}) {
    return TextStyle(
        fontSize: fz,
        letterSpacing: 0.14,
        height: 1.4,
        fontWeight: FontWeight.w400,
        color: color,
        decoration: td);
  }
}
