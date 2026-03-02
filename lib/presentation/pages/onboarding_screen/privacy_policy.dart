import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/constant_text.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/widgets/flutter_animation.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/bottom_navbar.dart';
import 'package:gms_application/presentation/pages/onboarding_screen/privacy_policy_details.dart';
class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  bool _isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),

            /// 🔐 TOP IMAGE
            Expanded(
              flex: 4,
              child: Center(
                child: Image.asset(
                  'assets/images/privacy.png',
                  fit: BoxFit.contain,
                ).animation.fadeScale(),
              ),
            ),

            /// 🤍 CARD SECTION
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 28.h),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(18.w, 32.h, 18.w, 28.h),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColors,
                    borderRadius: BorderRadius.circular(29.r),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 12.h),

                        /// 📝 TITLE
                        Text(
                          Constants.privacyTitleTxt,
                          textAlign: TextAlign.center,
                          style: FTextStyle.headingTxtPrimary.copyWith(
                            fontSize: 20.sp,
                            color: AppColors.textPrimary,
                          ),
                        )
                            .animation
                            .fade(duration: 500.ms),

                        SizedBox(height: 17.h),

                        /// 📄 DESCRIPTION
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: FTextStyle.privacyDecTxt.copyWith(
                              height: 1.93,
                              color: AppColors.textPrimary,
                            ),
                            children: const [
                              TextSpan(
                                text:
                                "To improve and personalize your experience and help grow the ",
                              ),
                              TextSpan(
                                text: "Khelo India Movement. ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                "SAI and the organizing committees for the Khelo India Games and our partners use cookies for analytics, people insights and marketing, as described in our Cookie Policy.",
                              ),
                            ],
                          ),
                        )
                            .animation
                            .fade(duration: 700.ms),

                        SizedBox(height: 37.h),

                        /// 👉 SLIDER
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            gradient: AppColors.acceptGradient,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.r),
                            child: ActionSlider.standard(
                              height: 45.h,
                              backgroundColor: AppColors.primaryColor,
                              toggleColor: _isSuccess
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              icon: _isSuccess
                                  ? Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                                  : Icon(
                                Icons.double_arrow_outlined,
                                color: AppColors.primaryColor,
                              ).animation.horizontalLoop(),

                              successIcon: Icon(
                                Icons.check_circle_outline,
                                color: AppColors.whiteColors,
                              ),
                              action: (controller) async {
                                controller.success();
                                setState(() {
                                  _isSuccess = true;
                                });

                                await Future.delayed(
                                    const Duration(seconds: 1));

                                if (!mounted) return;

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const BottomNavbar(),
                                  ),
                                );
                              },
                              child: Text(
                                Constants.acceptTxt.toUpperCase(),
                                style: FTextStyle.acceptTxtStyle.copyWith(
                                  color: AppColors.whiteColors,
                                ),
                              ),
                            ),
                          ),
                        )
                            .animation
                            .fromBottom(duration: 900.ms),

                        SizedBox(height: 18.h),

                        /// 🔗 POLICY LINK
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const PrivacyPolicyDetails(),
                              ),
                            );
                          },
                          child: Text(
                            Constants.privacyPolicyTxt,
                            style:
                            FTextStyle.privacyPolicyTxtStyle.copyWith(
                              decoration: TextDecoration.underline,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        )
                            .animation
                            .fade(duration: 1100.ms),
                        SizedBox(height: 18.h),
                      ],
                    ),
                  ),
                ).animation.fromBottom(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
