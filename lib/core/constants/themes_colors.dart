import 'package:flutter/material.dart';

class AppColors extends MaterialColor {
  const AppColors(super.primary, super.swatch);
  static const Color primaryColor = Color(0xFF37003C);
  static const Color lightPrimary = Color(0xFFFFF8FD);

  static const Color secondaryColor = Color(0xFFF37022);
  static const Color textSecondary = Color(0xFF8F8E9E);
  static const Color textPrimary = Color(0xFF080515);
  static const Color lightGreyPrimary = Color(0xFF7D7C81);

  static const Color whiteColors = Color(0xFFFFFFFF);
  static const Color whiteOffColors = Color(0xFFF6F6F6);
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryColor,
      whiteColors,
    ],
    stops: [0.45, 4.0],
  );
  // static const LinearGradient privacyPolicyGradient = LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   colors: [
  //     primaryColor,
  //     secondaryColor,
  //   ],
  //   stops: [0.35, 6.0],
  // );

  static const LinearGradient privacyPolicyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [

      lightPrimary,
  lightPrimary,


    ],
    stops: [6.0, 9.0],
  );
  static const LinearGradient acceptGradient =  const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFFFFFFF), // pure white (left)
      Color(0xFFFFFFFF), // very light off-white (middle)
      Color(0xFFFFFFFF), // light grey (right)
    ],
    stops: [
      0.2,
      0.65, // white covers almost half
      0.4,
    ],
  );
  static const LinearGradient warmGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
    primaryColor,
    secondaryColor,
    ],
  );
}
