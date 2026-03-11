import 'package:flutter/material.dart';

class Constants {
  Constants._();
  static const emailLabel = 'Email';
  static const passwordLabel = 'Password';
  static const rememberMeTxt = "Remember me";

  // Stakeholder login
  static const loginWelcomeTitle = 'Welcome Back';
  static const loginSubtitle =
      'Ready to continue your learning journey?\nYour path is right here.';
  static const loginNsrsEmailHint = 'Enter NSRS ID or Email';
  static const loginPasswordHint = 'Enter Password';
  static const loginForgotPassword = 'Forgot Password?';
  static const loginSubmit = 'Submit';
  static const loginLogoPath = 'assets/images/logo_flag.png';
  static const loginBackgroundPath = 'assets/images/loginBack.png';

  // Forgot password - set URL when backend provides it
  static const String? forgotPasswordUrl = null;
  static const privacyTitleTxt = "We Value Your Privacy";
  static const privacyPolicyTxt = "Privacy Policy";
  static const acceptTxt = "Accept";
  static const privacyDecTxt =
      "To improve and prosonalize your experience and help grow the khelo India Movment. SAI and the organizing Committees for the  Khelo India Games and our partenrs use cookies for analtics, pepole insights and marketing, as descrived in our Cooking Policy.";

  // About screen
  static const aboutTitle = 'About';
  static const aboutEventTitle = 'Khelo India Water Sports Festival Games 2026';
  static const aboutEventDescription =
      'The 2nd Edition kHelo India Beach Games (KIBG) is '
      'Scheduled to be held in UT Diu from 5th January to '
      '10th January 2026.\n\n'
      'The key features of the Khelo India Beach Beach Games (KIBG) '
      '2026 are as follows:\n\n'
      'No. of Sports Discipline: 8 (6 Competitive & 2 Demo) '
      'Sports Disciplines including sports like Beach Soccer, '
      'Beach Volleyball, Beach Pencak Competitive and Beach '
      'Mallakhamb & Beach Tug of war as Demo are part of the '
      'program.';

  // Schedule screen
  static const gameScheduleTitle = 'Game Schedule';
  static const noDatesAvailable = 'No dates available';
  static const noMatchesScheduled = 'No matches scheduled';
  static const selectMatchDate = 'Select Match Date';
}
