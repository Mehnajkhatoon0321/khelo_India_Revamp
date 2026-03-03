import 'package:flutter/material.dart';

class AppColors extends MaterialColor {
  const AppColors(super.primary, super.swatch);
  static const Color primaryColor = Color(0xFF37003C);
  static const Color lightPrimary = Color(0xFFFFF8FD);

  static const Color secondaryColor = Color(0xFFF37022);
  static const Color textSecondary = Color(0xFF8F8E9E);
  static const Color answerSecondary = Color(0xFF474747);
  static const Color textPrimary = Color(0xFF080515);
  static const Color lightGreyPrimary = Color(0xFF7D7C81);

  static const Color whiteColors = Color(0xFFFFFFFF);
  static const Color whiteOffColors = Color(0xFFF6F6F6);
  static const Color screenBackground = Color(0xFFF8F8F8);
  static const Color scheduleCardGrey = Color(0xFFF1F2F4);
  static const Color scheduleHeading = Color(0xFF20223A);
  static const Color scheduleDayText = Color(0xFF2D3044);
  static const Color scheduleMetaText = Color(0xFF61697B);
  static const Color scheduleMonthText = Color(0xFF5D6373);
  static const Color scheduleMutedText = Color(0xFF7A7E89);
  static const Color scheduleSubMutedText = Color(0xFF6E7380);
  static const Color scheduleWeekdayText = Color(0xFFA1A5B1);
  static const Color scheduleDateSelectedBg = Color(0xFF282E46);
  static const Color scheduleDateUnselectedBg = Color(0xFFC2C7CF);
  static const Color scheduleDateSelectedText = Color(0xFFFFFFFF);
  static const Color scheduleDateUnselectedText = Color(0xFF282E46);
  static const Color scheduleHandle = Color(0xFFD8DCE3);
  static const Color scheduleBorder = Color(0xFFE2E6ED);
  static const Color scheduleIconMuted = Color(0xFF989BA7);
  static const Color scheduleIconEnabled = Color(0xFF2A2F40);
  static const Color scheduleIconDisabled = Color(0xFFBCC0CA);
  static const Color shadowLight = Color(0x12000000);
  static const Color shadowMedium = Color(0x14000000);
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
