import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/constant_text.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/constants/themes_height_width.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';
import 'package:gms_application/core/widgets/responsive_layout.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  static const Color _primaryColor = AppColors.primaryColor;
  static const double _imageCardWidth = 333;
  static const double _imageCardHeight = 252;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColors,
      appBar: const CommonAppBar(
        title: Constants.aboutTitle,
        showNotification: true,
        backgroundColor: AppColors.whiteColors,
        showBottomDivider: false,
      ),
      body: SafeArea(
        top: false,
        child: ResponsiveContent(
          padding: EdgeInsets.fromLTRB(
            ResponsiveLayout.adaptiveHorizontalPadding(context),
            16,
            ResponsiveLayout.adaptiveHorizontalPadding(context),
            24,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double imageWidth = constraints.maxWidth < _imageCardWidth
                          ? constraints.maxWidth
                          : _imageCardWidth;
                      return Center(
                        child: Container(
                          width: imageWidth,
                          height: _imageCardHeight,
                          decoration: BoxDecoration(
                            color: AppColors.whiteOffColors,
                            borderRadius: BorderRadius.circular(11),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.whiteOffColors,
                                blurRadius: 14,
                                offset: Offset(3, 6),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.image_outlined,
                              color: Color(0xFFC9C9C9),
                              size: 72,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBoxConstant.heightSpace_40,
                  Text(
                    Constants.aboutEventTitle,
                    style: FTextStyle.aboutEventTitleStyle,
                  ),
                  SizedBoxConstant.heightSpace_15,
                  Container(
                    height: 3,
                    width: 70,
                    decoration: BoxDecoration(
                      color: _primaryColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  SizedBoxConstant.heightSpace_15,
                  Text(
                    Constants.aboutEventDescription,
                    style: FTextStyle.aboutEventDescriptionStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
