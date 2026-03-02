import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/constant_text.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/bottom_navbar.dart';
class PrivacyPolicyDetails extends StatefulWidget {
  const PrivacyPolicyDetails({super.key});

  @override
  State<PrivacyPolicyDetails> createState() => _PrivacyPolicyDetailsState();
}

class _PrivacyPolicyDetailsState extends State<PrivacyPolicyDetails> {
  bool _isSuccess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.privacyPolicyGradient,
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// 🌄 CENTER IMAGE (Always Visible)
              Image.asset(
                'assets/images/privacyBack.png',
                width: double.infinity,
                fit: BoxFit.fill,
                opacity: const AlwaysStoppedAnimation(0.9),
              ),

              /// 🧱 CONTENT OVER IMAGE
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 70,),

                    Center(
                      child: Container(
                        width: 90.w,
                        height: 90.w,
                        child: Image.asset(
                          'assets/images/privacy_lock.png',
                          width: double.infinity,
                          fit: BoxFit.contain,
                          opacity: const AlwaysStoppedAnimation(0.9),
                        ),
                      ),
                    ),
                    SizedBox(height: 25,),
                    /// 📝 Title
                    Text(
                      Constants.privacyTitleTxt,
                      textAlign: TextAlign.center,
                      style: FTextStyle.headingTxtPrimary,
                    ),
                    SizedBox(height: 15,),
                    /// 📄 Description
                    Text(
                      Constants.privacyDecTxt,
                      textAlign: TextAlign.center,
                      style: FTextStyle.privacyDecTxt,
                    ),
                    SizedBox(height: 25.h),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28.5.r),
                          border: Border.all(
                            color: AppColors.whiteColors,
                            width: 1,
                          ),
                          gradient:AppColors.acceptGradient
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28.5.r),
                        child: ActionSlider.standard(
                          height: 40.h,
                          sliderBehavior: SliderBehavior.move,
                          backgroundColor: Colors.transparent,
                          /// ⚪ Complete hote hi white
                          toggleColor:
                          _isSuccess ? Colors.white : AppColors.primaryColor,
                          /// ➡️ Arrow
                          icon: Container(
                            width: 45.w,
                            height: 45.h,
                            margin: EdgeInsets.only(left: 2.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                              _isSuccess ? Colors.white : AppColors.primaryColor,
                            ),
                            child: Icon(
                              Icons.double_arrow_outlined,
                              color:
                              _isSuccess ? AppColors.primaryColor : Colors.white,
                              size: 20,
                            ),
                          ),
                          /// 🔄 Loader (BLUE)
                          loadingIcon: SizedBox(
                            width: 55,
                            height: 55,
                            child: Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          /// ✔ Success (BLUE)
                          successIcon: SizedBox(
                            width: 60,
                            height: 60,
                            child: Center(
                              child: Icon(
                                Icons.check_circle_outline,
                                size: 25,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          child: Text(
                            Constants.acceptTxt.toUpperCase(),
                            style: FTextStyle.acceptTxtStyle.copyWith(
                              color:
                              AppColors.primaryColor,
                            ),
                          ),
                          action: (controller) async {
                            controller.success();
                            setState(() {
                              _isSuccess = true;
                              // ⚪ instantly white

                              // Navigate after some delay
                              Future.delayed(const Duration(seconds: 1), () {
                                if (!mounted) return;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>  BottomNavbar(),
                                  ),
                                );
                              });



                            });
                          },
                        ),
                      ),
                    ),
                    /// 👉 ACCEPT SLIDER
                    SizedBox(height: 30.h),
                    /// 🔗 Privacy Policy
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PrivacyPolicyDetails(),
                          ),
                        );
                      },
                      child: Text(
                        Constants.privacyPolicyTxt,
                        style: FTextStyle.privacyPolicyTxtStyle.copyWith(
                          decoration: TextDecoration.underline,


                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
