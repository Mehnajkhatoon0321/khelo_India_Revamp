import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/themes_colors.dart';

class FTextStyle {
  static TextStyle formErrorTxtStyle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    fontFamily: 'Montserrat',
  );

  //privacy policy Screen
  static TextStyle headingTxtPrimary = TextStyle(
    fontSize: 27.sp,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColors,
    height: 1.13,
    letterSpacing: 0,
  );
  static TextStyle textStylePrimary = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12.sp,
    color: AppColors.whiteColors,
    fontWeight: FontWeight.w600,
  );
  static TextStyle textSecBlackStylePrimary = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15.sp,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
  );
  static TextStyle smallPrimaryText = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13.sp,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w600,
  );
  static TextStyle privacyDecTxt = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13.sp,
    color: AppColors.whiteColors,
    fontWeight: FontWeight.w400,
    height: 1.93, // 193% line-height
    letterSpacing: 0,
  );

  // Privacy policy details (minimal / editorial)
  static TextStyle privacyDetailsHeaderTitle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16.sp,
    height: 1.25,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w700,
  );

  static TextStyle privacyDetailsHeaderSubtitle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13.sp,
    height: 1.6,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w400,
  );

  static TextStyle privacyDetailsSectionTitle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15.sp,
    height: 1.3,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w700,
  );

  static TextStyle privacyDetailsBody = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13.sp,
    height: 1.75,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w400,
  );

  static TextStyle privacyDetailsMeta = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12.sp,
    height: 1.4,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w600,
  );
  static TextStyle helloTxt = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13.sp,
    color: AppColors.lightGreyPrimary,
    fontWeight: FontWeight.w500,
    height: 1.12, // 193% line-height
    letterSpacing: 0,
  );

  static TextStyle acceptTxtStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500, // Medium
    height: 1.23, // 123% line-height
    letterSpacing: 3, // 3px
    color: AppColors.primaryColor,
  );
  static TextStyle privacyPolicyTxtStyle = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    fontFamily: 'Montserrat',
    color: AppColors.primaryColor,

    decoration: TextDecoration.underline,
    decorationColor: AppColors.primaryColor, // 👈 underline color
    decorationThickness: 1.3, // optional (looks cleaner)
  );

  static TextStyle navbarDefault = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    fontFamily: 'Montserrat',
    color: AppColors.black,
    height: 1.13,
    letterSpacing: 0,
  );
  static TextStyle navbarSelected = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
    height: 1.13,
    letterSpacing: 0,
  );
  static TextStyle heading = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: AppColors.whiteColors,
    height: 1.36,
    letterSpacing: 0,
  );
  static TextStyle subHeading = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 11.sp,
    color: AppColors.whiteColors,
    height: 1.36,
    letterSpacing: 0,
  );

  static TextStyle chipText = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 9.sp, // Figma 9px
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w500, // Medium = 500
    height: 1.13, // 113% line-height
    letterSpacing: 0,
  );
  static TextStyle cardTileText = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 10.sp, // Figma 9px
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600, // ⭐ SemiBold
    height: 1.34, // ⭐ 134% line-height
    letterSpacing: 0,
  );
  static const TextStyle datePicker = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w400,
    fontSize: 8,
    height: 1.34, // 134% line height
    letterSpacing: 0,
  );
  static TextStyle medalSub = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w600,

    fontSize: 7.sp,
    height: 1.34,
    letterSpacing: 0,
    color: AppColors.whiteColors.withOpacity(.85), // ⭐ medal card par soft look
  );

  static TextStyle aboutEventTitleStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    height: 1.31,
    color: AppColors.appBarTitle,
    letterSpacing: 0,
  );

  static TextStyle aboutEventDescriptionStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    height: 1.75,
    color: AppColors.scheduleMonthText,
    letterSpacing: 0,
  );

  static TextStyle scheduleMonthHeadingStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.scheduleHeading,
  );

  static TextStyle scheduleNoDateStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.scheduleMutedText,
  );

  static TextStyle scheduleDateNumberStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.scheduleDayText,
  );

  static TextStyle scheduleDateDayStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.scheduleWeekdayText,
  );

  static TextStyle scheduleDateSelectedNumberStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    height: 1.13,
    letterSpacing: 0,
    color: AppColors.scheduleDateSelectedText,
  );

  static TextStyle scheduleDateSelectedMonthStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 9.sp,
    fontWeight: FontWeight.w600,
    height: 1.13,
    letterSpacing: 0,
    color: AppColors.scheduleDateSelectedText,
  );

  static TextStyle scheduleDateUnselectedNumberStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    height: 1.13,
    letterSpacing: 0,
    color: AppColors.scheduleDateUnselectedText,
  );

  static TextStyle scheduleDateUnselectedMonthStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 9.sp,
    fontWeight: FontWeight.w600,
    height: 1.13,
    letterSpacing: 0,
    color: AppColors.scheduleDateUnselectedText,
  );

  static TextStyle scheduleMonthChipStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.scheduleMonthText,
  );

  static TextStyle scheduleEmptyMatchStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.scheduleSubMutedText,
  );

  static TextStyle scheduleMatchTitleStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 17.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.scheduleHeading,
  );

  static TextStyle scheduleMatchMetaStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.scheduleMetaText,
  );

  static TextStyle scheduleDetailsSportTitleStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle scheduleDetailsMetaStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle scheduleDetailsEventTitleStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle scheduleDetailsEventMetaStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle scheduleUnifiedHeadingStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle scheduleAthleteNameStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle scheduleAthleteLabelStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 9.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.scheduleAthleteLabelText,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle scheduleAthleteValueStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle scheduleAthleteKIdValueStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle scheduleAthleteStatusPresentStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.scheduleAthletePresent,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle scheduleAthleteStatusAbsentStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.scheduleAthleteAbsent,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle appBarTitleStyle = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.appBarTitle,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle faqChipStyle = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.13,
  );

  static TextStyle faqQuestionStyle = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.54,
  );

  static TextStyle faqAnswerStyle = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 11.sp,
    fontWeight: FontWeight.w300,
    color: AppColors.answerSecondary,
    height: 1.64,
  );

  static TextStyle latestNewsTitleStyle = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  static TextStyle latestNewsDateStyle = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
  );

  static TextStyle noDataTitleStyle = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  static TextStyle noDataSubtitleStyle = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle competitionDescriptionStyle = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 2,
    color: AppColors.whiteColors,
  );

  static TextStyle competitionButtonStyle = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColors,
  );

  // Login screen
  static TextStyle loginTitleStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 34.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.whiteColors,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle loginSubtitleStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
    height: 1.5,
  );

  static TextStyle loginInputStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteOffColors,
    height: 1.22,
  );

  static TextStyle loginHintStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white70,
    height: 1.3,
  );

  static TextStyle loginRememberMeStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColors,
    height: 1.5,
  );

  static TextStyle loginForgotPasswordStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColors,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.whiteColors,
    decorationThickness: 1.5,
  );

  static TextStyle loginButtonStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.3,
  );
}
