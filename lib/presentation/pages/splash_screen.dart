import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/constants/themes_height_width.dart';
import 'package:gms_application/core/widgets/flutter_animation.dart';
import 'package:gms_application/core/utils/simple_translator.dart';
import 'package:gms_application/presentation/pages/onboarding_screen/competition_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after some delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CompetitionSelectionScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove backgroundColor
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.splashGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TrText(
                "Khelo India Games",
                style: FTextStyle.headingTxtPrimary,
              ).animation.fadeScale(),
              SizedBoxConstant.heightSpace_8,
              TrText(
                "TRIUMPH OF WILL AMPLIFIED BY ALGORITHMS",
                style: FTextStyle.textStylePrimary,
              ).animation.fadeScale(),
            ],
          ),
        ),
      ),
    );
  }
}
