import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';

class LatestViewDetails extends StatelessWidget {
  const LatestViewDetails({
    super.key,
    required this.title,
    required this.date,
    required this.type,
    required this.media,
    required this.description,
  });

  final String title;
  final String date;
  final String type;
  final String media;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColors,
      appBar: const CommonAppBar(
        title: 'Latest News',
        showBack: true,
        showNotification: true,
        backgroundColor: AppColors.whiteColors,
        showBottomDivider: true,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: SizedBox(
                  width: double.infinity,
                  height: 250.h,
                  child: _buildMediaPreview(),
                ),
              ),
              SizedBox(height: 16.h),
              TrText(
                title,
                style: FTextStyle.textSecBlackStylePrimary.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              TrText(
                date,
                style: FTextStyle.latestNewsDateStyle.copyWith(
                  fontSize: 18 * 0.75,
                ),
              ),
              SizedBox(height: 14.h),
              const Divider(color: AppColors.appBarDivider, thickness: 0.5),
              SizedBox(height: 14.h),
              TrText(
                description.trim().isEmpty
                    ? 'Detailed news description not available.'
                    : description,
                style: FTextStyle.latestNewsDateStyle.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 22 * 0.72,
                  height: 1.7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPreview() {
    if (type.toLowerCase() == 'image' && media.isNotEmpty) {
      return Image.network(
        media,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(color: AppColors.black),
      );
    }
    return Container(color: AppColors.black);
  }
}
