// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
//
//
// class AppAnimation {
//   final Widget child;
//   Animate? _animate;
//
//   AppAnimation(this.child) {
//
//     _animate = child.animate();
//   }
//
//   /// Fade animation
//   Widget fade({Duration duration = const Duration(milliseconds: 600)}) {
//     return _animate!.fadeIn(duration: duration, curve: Curves.easeOut);
//   }
//
//   /// Scale animation
//   Widget scale({Duration duration = const Duration(milliseconds: 600)}) {
//     return _animate!.scale(
//       begin: const Offset(0.9, 0.9),
//       duration: duration,
//       curve: Curves.easeOut,
//     );
//   }
//
//   /// Slide from left
//   Widget fromLeft({Duration duration = const Duration(milliseconds: 600)}) {
//     return _animate!.slideX(begin: -0.3, duration: duration, curve: Curves.easeOut);
//   }
//
//   /// Slide from right
//   Widget fromRight({Duration duration = const Duration(milliseconds: 600)}) {
//     return _animate!.slideX(begin: 0.3, duration: duration, curve: Curves.easeOut);
//   }
//
//   /// Slide from bottom
//   Widget fromBottom({Duration duration = const Duration(milliseconds: 600)}) {
//     return _animate!.slideY(begin: 0.3, duration: duration, curve: Curves.easeOut);
//   }
//
//   /// Fade + Scale animation (good for splash & dialogs)
//   Widget fadeScale({Duration duration = const Duration(milliseconds: 700)}) {
//     return _animate!.fadeIn(duration: duration, curve: Curves.easeOut)
//         .scale(begin: const Offset(0.9, 0.9));
//   }
// }
//
// /// Extension on Widget to call animations directly
// extension WidgetAnimationExtension on Widget {
//   AppAnimation get animation => AppAnimation(this);
// }


import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppAnimation {
  final Widget child;

  AppAnimation(this.child);

  Widget fade({Duration duration = const Duration(milliseconds: 600)}) {
    return child.animate().fadeIn(
      duration: duration,
      curve: Curves.easeOut,
    );
  }

  Widget scale({Duration duration = const Duration(milliseconds: 600)}) {
    return child.animate().scale(
      begin: const Offset(0.9, 0.9),
      duration: duration,
      curve: Curves.easeOut,
    );
  }

  Widget fromLeft({Duration duration = const Duration(milliseconds: 600)}) {
    return child.animate().slideX(
      begin: -0.3,
      duration: duration,
      curve: Curves.easeOut,
    );
  }

  Widget fromRight({Duration duration = const Duration(milliseconds: 600)}) {
    return child.animate().slideX(
      begin: 0.3,
      duration: duration,
      curve: Curves.easeOut,
    );
  }

  Widget fromBottom({Duration duration = const Duration(milliseconds: 600)}) {
    return child.animate().slideY(
      begin: 0.3,
      duration: duration,
      curve: Curves.easeOut,
    );
  }

  Widget fadeScale({Duration duration = const Duration(milliseconds: 700)}) {
    return child
        .animate()
        .fadeIn(duration: duration, curve: Curves.easeOut)
        .scale(begin: const Offset(0.9, 0.9));
  }

  /// 🔥 NEW: Continuous horizontal hint animation
  Widget horizontalLoop({
    double begin = -5,
    double end = 5,
    Duration duration = const Duration(milliseconds: 800),
  }) {
    return child
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveX(
      begin: begin,
      end: end,
      duration: duration,
      curve: Curves.easeInOut,
    );
  }
}

extension WidgetAnimationExtension on Widget {
  AppAnimation get animation => AppAnimation(this);
}
