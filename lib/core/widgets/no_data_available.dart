import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';

/// A beautiful illustration for empty medal/athlete list state.
class EmptyMedalIllustration extends StatelessWidget {
  const EmptyMedalIllustration({super.key, this.size = 160});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _EmptyMedalPainter(),
        size: Size(size, size),
      ),
    );
  }
}

class _EmptyMedalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double cx = w * 0.5;
    final double cy = h * 0.48;

    // Outer soft glow circle
    final Paint bgPaint = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          AppColors.primaryColor.withOpacity(0.08),
          AppColors.primaryColor.withOpacity(0.02),
          Colors.transparent,
        ],
        stops: const <double>[0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: w * 0.5));
    canvas.drawCircle(Offset(cx, cy), w * 0.48, bgPaint);

    // Decorative ring
    final Paint ringPaint = Paint()
      ..color = AppColors.primaryColor.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(cx, cy), w * 0.42, ringPaint);

    // Trophy cup body - rounded trapezoid (cup shape)
    final Path cupPath = Path()
      ..moveTo(cx - w * 0.22, cy + h * 0.08)
      ..lineTo(cx - w * 0.28, cy + h * 0.22)
      ..quadraticBezierTo(
        cx - w * 0.30, cy + h * 0.26,
        cx - w * 0.24, cy + h * 0.26,
      )
      ..lineTo(cx + w * 0.24, cy + h * 0.26)
      ..quadraticBezierTo(
        cx + w * 0.30, cy + h * 0.26,
        cx + w * 0.28, cy + h * 0.22,
      )
      ..lineTo(cx + w * 0.22, cy + h * 0.08)
      ..quadraticBezierTo(cx + w * 0.24, cy - h * 0.02, cx, cy - h * 0.18)
      ..quadraticBezierTo(cx - w * 0.24, cy - h * 0.02, cx - w * 0.22, cy + h * 0.08)
      ..close();

    final Paint cupPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          AppColors.medalFirstGradientStart,
          AppColors.medalSecondGradientStart,
          AppColors.medalThirdGradientStart.withOpacity(0.9),
        ],
        stops: const <double>[0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(cupPath, cupPaint);

    // Cup outline for definition
    final Paint cupStroke = Paint()
      ..color = AppColors.primaryColor.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawPath(cupPath, cupStroke);

    // Two small medal circles (empty slots) below
    final double medalY = cy + h * 0.32;
    for (int i = -1; i <= 1; i += 2) {
      final double mx = cx + (i * w * 0.2);
      final Paint medalBg = Paint()
        ..color = AppColors.scheduleCardBorder.withOpacity(0.6)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(mx, medalY), w * 0.06, medalBg);
      final Paint medalStroke = Paint()
        ..color = AppColors.primaryColor.withOpacity(0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      canvas.drawCircle(Offset(mx, medalY), w * 0.06, medalStroke);
    }

    // Center "?" or empty accent - subtle dot
    final Paint dotPaint = Paint()
      ..color = AppColors.primaryColor.withOpacity(0.25);
    canvas.drawCircle(Offset(cx, cy - h * 0.04), w * 0.04, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NoDataAvailable extends StatelessWidget {
  const NoDataAvailable({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.illustration,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  /// When set, this widget is shown instead of the default icon circle.
  final Widget? illustration;

  @override
  Widget build(BuildContext context) {
    final sTitle = title.trim().isEmpty ? "No data found" : title.trim();

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (illustration != null)
              illustration!
            else
              Container(
                height: 74.sp,
                width: 74.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
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
            if (subtitle != null && subtitle!.trim().isNotEmpty) ...<Widget>[
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
