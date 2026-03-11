import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';

class NoDataAvailable extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  const NoDataAvailable({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    final sTitle = title.trim().isEmpty ? "No data found" : title.trim();

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 74.sp,
              width: 74.sp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryColor.withOpacity(.12),
                    AppColors.primaryColor.withOpacity(.04),
                  ],
                ),
                border:
                    Border.all(color: AppColors.primaryColor.withOpacity(.10)),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryColor.withOpacity(.85),
                size: 34.sp,
              ),
            ),
            SizedBox(height: 14.h),
            TrText(
              sTitle,
              textAlign: TextAlign.center,
              style: FTextStyle.noDataTitleStyle,
            ),
            if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
              SizedBox(height: 6.h),
              TrText(
                subtitle!.trim(),
                textAlign: TextAlign.center,
                style: FTextStyle.noDataSubtitleStyle,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
