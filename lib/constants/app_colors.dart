import 'package:bhagwat_gita/constants/constant_strings.dart';
import 'package:bhagwat_gita/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static Color backgroundColor = getBackGroundColor();
  static Color defaultBackgroundColor = const Color(0xff121212);
  static Color textColor1 = getTextColor();
  static Color textColor2 = getTextColor();
  static Color textColor3 = getTextColor();
  static Color primaryButtonColor = const Color(0xff6200EE);
  static Color actionButtonColor = const Color(0xff03DAC6);
  static Color lightYellow = getHighlightColor();
  static Color black = Colors.black;
  static Color white = Colors.white;
  static Color dividerColor = Colors.transparent;

  // Reading Background Colors
  static Color softGrayBackground = const Color(0xffF5F5F5); // Soft Light Gray
  static Color softGrayText = const Color(0xff333333);

  static Color sepiaBackground = const Color(0xffFAF3E0); // Light Sepia
  static Color sepiaText = const Color(0xff4E4E4E); // Dim Gray

  static Color blueGrayBackground = const Color(0xffEAF0F6); // Light Blue-Gray
  static Color blueGrayText = const Color(0xff2C2C2C); // Very Dark Gray

  static Color creamyYellowBackground = const Color(0xffFFF9E5); // Creamy Yellow
  static Color creamyYellowText = const Color(0xff1A1A1A); // Almost Black

  static Color darkModeBackground = Colors.black; // Deep Black
  static Color darkModeText = const Color(0xffE0E0E0); // Light Gray

  static Color getBackGroundColor() {
    final colorType = Prefs.getString("Color");
    switch (colorType) {
      case ConstantStrings.softGreyBakcground:
        backgroundColor = softGrayBackground;
        return softGrayBackground;
      case ConstantStrings.sepiaBackground:
        backgroundColor = sepiaBackground;
        return sepiaBackground;
      case ConstantStrings.defaultBakcground:
        backgroundColor = defaultBackgroundColor;
        return defaultBackgroundColor;
      case ConstantStrings.darkModeBlackBakcground:
        backgroundColor = darkModeBackground;
        return darkModeBackground;
      case ConstantStrings.creamyTintYellowBakcground:
        backgroundColor = creamyYellowBackground;
        return creamyYellowBackground;
      case ConstantStrings.brightWhiteBakcground:
        backgroundColor = Colors.white;
        return Colors.white;
      case ConstantStrings.blueGreyBackground:
        backgroundColor = blueGrayBackground;
        return blueGrayBackground;
      default:
        backgroundColor = defaultBackgroundColor;
        return defaultBackgroundColor;
    }
  }

  static Color getTextColor() {
    final colorType = Prefs.getString("Color");
    switch (colorType) {
      case ConstantStrings.softGreyBakcground:
        textColor1 = softGrayText;
        textColor2 = softGrayText;
        textColor3 = softGrayText;
        return softGrayText;
      case ConstantStrings.sepiaBackground:
        textColor1 = sepiaText;
        textColor2 = sepiaText;
        textColor3 = sepiaText;
        return sepiaText;
      case ConstantStrings.defaultBakcground:
        textColor1 = const Color(0xffE0E0E0);
        textColor2 = const Color(0xffE0E0E0);
        textColor3 = const Color(0xffE0E0E0);
        return const Color(0xffE0E0E0); // Default Light Gray
      case ConstantStrings.darkModeBlackBakcground:
        textColor1 = darkModeText;
        textColor2 = darkModeText;
        textColor3 = darkModeText;
        return darkModeText;
      case ConstantStrings.creamyTintYellowBakcground:
        textColor1 = creamyYellowText;
        textColor2 = creamyYellowText;
        textColor3 = creamyYellowText;
        return creamyYellowText;
      case ConstantStrings.brightWhiteBakcground:
        textColor1 = Colors.black;
        textColor2 = Colors.black;
        textColor3 = Colors.black;
        return Colors.black;
      case ConstantStrings.blueGreyBackground:
        textColor1 = blueGrayText;
        textColor2 = blueGrayText;
        textColor3 = blueGrayText;
        return blueGrayText;
      default:
        return const Color(0xffE0E0E0); // Default Light Gray
    }
  }

  static Color getHighlightColor() {
    final colorType = Prefs.getString("Color");
    switch (colorType) {
      case ConstantStrings.softGreyBakcground:
        lightYellow = Colors.teal;
        return Colors.teal;
      case ConstantStrings.sepiaBackground:
       lightYellow = Colors.teal;
        return Colors.teal;
      case ConstantStrings.defaultBakcground:
        lightYellow = Colors.amber.shade100;
        return Colors.amber.shade100;// Default Light Gray
      case ConstantStrings.darkModeBlackBakcground:
        lightYellow = Colors.amber.shade100;
        return Colors.amber.shade100;
      case ConstantStrings.creamyTintYellowBakcground:
       lightYellow = Colors.teal;
        return Colors.teal;
      case ConstantStrings.brightWhiteBakcground:
        lightYellow = Colors.teal;
        return Colors.teal;
      case ConstantStrings.blueGreyBackground:
        lightYellow = Colors.teal;
        return Colors.teal;
      default:
        return Colors.amber.shade100; // Default Light Gray
    }
  }
}
