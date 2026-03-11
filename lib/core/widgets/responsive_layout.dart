import 'package:flutter/material.dart';

class ResponsiveLayout {
  static double adaptiveHorizontalPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1200) return 32;
    if (width >= 900) return 24;
    return 16;
  }

  static double adaptiveMaxContentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1400) return 1080;
    if (width >= 1100) return 980;
    if (width >= 900) return 860;
    return width;
  }
}

class ResponsiveContent extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;
  final double? maxWidth;

  const ResponsiveContent({
    super.key,
    required this.child,
    this.padding,
    this.alignment = Alignment.topCenter,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ??
        EdgeInsets.symmetric(
            horizontal: ResponsiveLayout.adaptiveHorizontalPadding(context));

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth:
              maxWidth ?? ResponsiveLayout.adaptiveMaxContentWidth(context),
        ),
        child: Padding(
          padding: effectivePadding,
          child: child,
        ),
      ),
    );
  }
}
