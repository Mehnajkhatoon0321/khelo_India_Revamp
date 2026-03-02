import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
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
                border: Border.all(color: AppColors.primaryColor.withOpacity(.10)),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryColor.withOpacity(.85),
                size: 34.sp,
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              sTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                height: 1.25,
              ),
            ),
            if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
              SizedBox(height: 6.h),
              Text(
                subtitle!.trim(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
