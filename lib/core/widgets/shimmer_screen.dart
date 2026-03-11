import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable shimmer/skeleton widgets.
///
/// Usage examples:
/// - `GmsShimmer(child: YourSkeleton())`
/// - `ShimmerLine(widthFactor: .6)`
/// - `ShimmerCard.large()`, `ShimmerCard.tile()`, `ShimmerCard.faq()`
class GmsShimmer extends StatefulWidget {
  final Widget child;
  final Duration period;
  final Color baseColor;
  final Color highlightColor;
  final BorderRadiusGeometry? borderRadius;

  const GmsShimmer({
    super.key,
    required this.child,
    this.period = const Duration(milliseconds: 1200),
    this.baseColor = const Color(0xFFEDEDED),
    this.highlightColor = const Color(0xFFF7F7F7),
    this.borderRadius,
  });

  @override
  State<GmsShimmer> createState() => _GmsShimmerState();
}

class _GmsShimmerState extends State<GmsShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: widget.period)..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) {
        final t = _c.value;
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (rect) {
            final dx = rect.width * (t * 2 - 1); // -w..+w
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.35, 0.5, 0.65],
              transform: _SlideGradientTransform(dx),
            ).createShader(rect);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlideGradientTransform extends GradientTransform {
  final double slideX;
  const _SlideGradientTransform(this.slideX);

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(slideX, 0, 0);
  }
}

/// A rounded rectangular skeleton block.
class ShimmerBox extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry borderRadius;
  final Color color;

  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.color = const Color(0xFFEDEDED),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
    );
  }
}

/// Text-like skeleton line that can vary width.
class ShimmerLine extends StatelessWidget {
  final double height;
  final double widthFactor;
  final double radius;

  const ShimmerLine({
    super.key,
    this.height = 10,
    this.widthFactor = 1,
    this.radius = 10,
  }) : assert(widthFactor > 0 && widthFactor <= 1);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: Alignment.centerLeft,
      child: ShimmerBox(
        height: height.h,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }
}

/// A group of lines with natural looking varied widths.
class ShimmerParagraph extends StatelessWidget {
  final int lines;
  final double lineHeight;
  final double spacing;
  final double minWidthFactor;
  final double maxWidthFactor;

  const ShimmerParagraph({
    super.key,
    this.lines = 3,
    this.lineHeight = 10,
    this.spacing = 8,
    this.minWidthFactor = .55,
    this.maxWidthFactor = 1,
  });

  @override
  Widget build(BuildContext context) {
    final seed = DateTime.now().millisecondsSinceEpoch % 997;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(lines, (i) {
        final f = _lerp(
          maxWidthFactor,
          minWidthFactor,
          (math.sin((seed + i) * 1.7) + 1) / 2,
        ).clamp(minWidthFactor, maxWidthFactor);
        return Padding(
          padding: EdgeInsets.only(bottom: i == lines - 1 ? 0 : spacing.h),
          child: ShimmerLine(height: lineHeight, widthFactor: f),
        );
      }),
    );
  }
}

double _lerp(double a, double b, double t) => a + (b - a) * t;

/// Prebuilt skeletons that match your UI patterns.
class ShimmerCard {
  /// Latest News "Today News" big card skeleton.
  static Widget large() {
    return GmsShimmer(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFEDEDED)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBox(
              height: 160.h,
              width: double.infinity,
              borderRadius: BorderRadius.circular(12.r),
            ),
            SizedBox(height: 12.h),
            const ShimmerParagraph(
                lines: 2, lineHeight: 12, spacing: 8, minWidthFactor: .65),
            SizedBox(height: 10.h),
            const ShimmerLine(height: 10, widthFactor: .35),
          ],
        ),
      ),
    );
  }

  /// Latest News list tile skeleton.
  static Widget tile() {
    return GmsShimmer(
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            ShimmerBox(
              height: 64.w,
              width: 64.w,
              borderRadius: BorderRadius.circular(12.r),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerLine(height: 12, widthFactor: .85),
                  SizedBox(height: 8),
                  ShimmerLine(height: 10, widthFactor: .45),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            const ShimmerBox(
              height: 30,
              width: 30,
              borderRadius: BorderRadius.all(Radius.circular(999)),
            ),
          ],
        ),
      ),
    );
  }

  /// FAQ card skeleton (question + plus icon).
  static Widget faq() {
    return GmsShimmer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE9E9E9)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: ShimmerParagraph(
                  lines: 2, lineHeight: 12, spacing: 8, minWidthFactor: .7),
            ),
            SizedBox(width: 10),
            ShimmerBox(
                height: 18,
                width: 18,
                borderRadius: BorderRadius.all(Radius.circular(6))),
          ],
        ),
      ),
    );
  }
}
