import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';

class CompetitionSelectionScreen extends StatefulWidget {
  const CompetitionSelectionScreen({super.key});

  @override
  State<CompetitionSelectionScreen> createState() =>
      _CompetitionSelectionScreenState();
}

class _CompetitionSelectionScreenState
    extends State<CompetitionSelectionScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  final List<String> competitionImages = [
    'assets/images/comptetion.png',
    'assets/images/comptetion.png',
    'assets/images/comptetion.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < competitionImages.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = size.width / 375;

    return Scaffold(
      body: Stack(
        children: [
          /// 1️⃣ PURPLE FULL BACKGROUND (BASE)
          Container(
            color: AppColors.primaryColor,
          ),

          /// 2️⃣ WHITE CURVED TOP
          ClipPath(
            clipper: PerfectBottomCurveClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.48,
              color: AppColors.whiteColors,
            ),
          ),

          /// 3️⃣ IMAGE SLIDER
          Positioned(
            top: 20 * scale,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 275 * scale,
              child: PageView.builder(
                controller: _pageController,
                itemCount: competitionImages.length,
                itemBuilder: (_, index) {
                  return Image.asset(
                    competitionImages[index],
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ),

          /// 4️⃣ INDICATOR
          Positioned(
            top: MediaQuery.of(context).size.height * 0.39,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                competitionImages.length,
                (i) => circularDot(i == _currentIndex),
              ),
            ),
          ),

          /// 5️⃣ TEXT
          Positioned(
            top: MediaQuery.of(context).size.height * 0.50,
            left: 24,
            right: 24,
            child: TrText(
              "The Importance of Sports and fitness in one's life is invaluable. "
              "A fit and healthy individual leads to an equally healthy society "
              "and strong nation. The Khelo India Programme has been introduced "
              "to revive the sports culture in India at the grass-root level by "
              "building a strong framework for all sports & establish India a "
              "Great Sporting Nation.",
              textAlign: TextAlign.center,
              style: FTextStyle.competitionDescriptionStyle.copyWith(
                color: AppColors.whiteColors.withOpacity(0.9),
              ),
            ),
          ),

          /// 6️⃣ SELECT GAMES BUTTON
          Positioned(
            top: MediaQuery.of(context).size.height * 0.70,
            left: 24,
            right: 24,
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border:
                    Border.all(color: AppColors.whiteColors.withOpacity(0.6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TrText(
                    "Select Games",
                    style: FTextStyle.competitionButtonStyle,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.whiteColors,
                  ),
                ],
              ),
            ),
          ),

          /// 7️⃣ BOTTOM LEFT DECOR
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: 140 * scale,
              child: Image.asset(
                'assets/images/left_corner_comp.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          /// 8️⃣ BOTTOM RIGHT DECOR
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/right_corner_comp.png',
              width: 110 * scale,
            ),
          ),
        ],
      ),
    );
  }

  /// CIRCULAR BORDER INDICATOR (MATCHES IMAGE)
  Widget circularDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 12 : 10,
      height: isActive ? 12 : 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.scheduleMetaText,
          width: 0.5, // 👈 exact Figma border
        ),
      ),
      child: isActive
          ? Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
              ),
            )
          : null,
    );
  }
}

/// CURVE CLIPPER (UNCHANGED)
class PerfectBottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 95);

    path.quadraticBezierTo(
      size.width / 2,
      size.height + 48,
      size.width,
      size.height - 95,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gms_application/core/constants/themes_colors.dart';
//
// class CompetitionSelectionScreen extends StatefulWidget {
//   const CompetitionSelectionScreen({super.key});
//
//   @override
//   State<CompetitionSelectionScreen> createState() =>
//       _CompetitionSelectionScreenState();
// }
//
// class _CompetitionSelectionScreenState
//     extends State<CompetitionSelectionScreen> {
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;
//   Timer? _timer;
//
//   final List<String> competitionImages = [
//     'assets/images/comptetion.png',
//     'assets/images/comptetion.png',
//     'assets/images/comptetion.png',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.immersiveSticky,
//     );
//     _startAutoScroll();
//   }
//
//   void _startAutoScroll() {
//     _timer = Timer.periodic(const Duration(seconds: 3), (_) {
//       _currentIndex =
//           (_currentIndex + 1) % competitionImages.length;
//
//       _pageController.animateToPage(
//         _currentIndex,
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//
//           /// 1️⃣ PURPLE BACKGROUND
//           Container(color: AppColors.primaryColor),
//
//           /// 2️⃣ WHITE CURVE
//           ClipPath(
//             clipper: PerfectBottomCurveClipper(),
//             child: Container(
//               height: 0.48.sh,
//               color: Colors.white,
//             ),
//           ),
//
//           /// 3️⃣ IMAGE SLIDER
//           Positioned(
//             top: 0.h,
//             left: 0,
//             right: 0,
//             child: SizedBox(
//               height: 270.h,
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: competitionImages.length,
//                 itemBuilder: (_, index) {
//                   return Image.asset(
//                     competitionImages[index],
//                     fit: BoxFit.contain,
//                   );
//                 },
//               ),
//             ),
//           ),
//
//           /// 4️⃣ INDICATOR
//           Positioned(
//             top: 0.39.sh,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 competitionImages.length,
//                     (i) => circularDot(i == _currentIndex),
//               ),
//             ),
//           ),
//
//           /// 5️⃣ DESCRIPTION TEXT
//           Positioned(
//             top: 0.47.sh,
//             left: 24.w,
//             right: 24.w,
//             child: Text(
//               "Sports and fitness are the backbone of a healthy life. A fitter individual contributes to a healthier society and nation. The Khelo India Programme is designed to foster sports culture from the grassroots, laying the foundation for India to become a global sporting leader.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 13.sp,
//                 height: 2,
//                 color: Colors.white.withOpacity(0.9),
//                 fontFamily: 'Montserrat',
//               ),
//             ),
//           ),
//
//           /// 6️⃣ SELECT GAMES BUTTON
//           Positioned(
//             top: 0.70.sh,
//             left: 24.w,
//             right: 24.w,
//             child: Container(
//               height: 125.h,  // Set a fixed height for the container
//               width: double.infinity,  // Full width
//               padding: EdgeInsets.zero,  // Remove any default padding in the container
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,  // Make the scroll horizontal
//                 padding: EdgeInsets.zero,  // Ensure SingleChildScrollView has no padding
//                 child: Row(
//                   children: List.generate(
//                     competitionImages.length,  // Number of items
//                         (index) => GestureDetector(
//                       onTap: () {
//                         // Handle selection
//                         print('Selected ${competitionImages[index]}');
//                       },
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16.r),
//                         ),
//                         elevation: 8,
//                         shadowColor: Colors.black.withOpacity(0.3),
//                         margin: EdgeInsets.only(right: 12.w),  // Right margin between the cards
//                         child: Container(
//                           width: 125.w,  // Fixed width for the card
//                           height: 126.h,  // Fixed height for the card
//                           padding: EdgeInsets.all(8.w),  // Padding inside the card for spacing
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(12.r),
//                                 child: Image.asset(
//                                   competitionImages[index],
//                                   height: 70.h,  // Set a fixed height for the image
//                                   width: 70.w,  // Set a fixed width for the image
//                                   fit: BoxFit.cover,  // Ensure the image fits in the available space
//                                 ),
//                               ),
//                               SizedBox(height: 4.h),  // Space between image and text
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 10.w),
//                                 child: Text(
//                                   "University Games 2025",  // Long text example
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize: 13.sp,  // Font size
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black.withOpacity(0.7),  // Text color with opacity
//                                   ),
//                                   maxLines: 2,  // Limit text to two lines
//                                   overflow: TextOverflow.ellipsis,  // Prevent text overflow, show "..."
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           )
//
//
//
//
//
//
//
//           ,
//           // Positioned(
//           //   top: 0.68.sh,
//           //   left: 24.w,
//           //   right: 24.w,
//           //   child: GridView.builder(
//           //     shrinkWrap: true,
//           //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           //       crossAxisCount: 3, // You can change this based on how many cards fit per row
//           //       crossAxisSpacing: 4.w,
//           //       mainAxisSpacing: 12.h,
//           //     ),
//           //     itemCount: competitionImages.length, // Use this to determine how many cards
//           //     itemBuilder: (_, index) {
//           //       return GestureDetector(
//           //         onTap: () {
//           //           // Handle selection
//           //           print('Selected ${competitionImages[index]}');
//           //         },
//           //         child: Card(
//           //           shape: RoundedRectangleBorder(
//           //             borderRadius: BorderRadius.circular(12.r),
//           //           ),
//           //           elevation: 4,
//           //           child: Column(
//           //             mainAxisAlignment: MainAxisAlignment.center,
//           //             crossAxisAlignment: CrossAxisAlignment.center, // Center the text
//           //             children: [
//           //               Image.asset(
//           //                 competitionImages[index],
//           //                 height: 80.h, // Adjust the height to make space for text
//           //                 fit: BoxFit.contain, // Ensure the image doesn't stretch
//           //               ),
//           //               SizedBox(height: 8.h), // Add space between image and text
//           //               Flexible(
//           //                 child: Text(
//           //                   "Youth Games ${index + 1}", // Replace with actual game names
//           //                   textAlign: TextAlign.center,
//           //                   style: TextStyle(
//           //                     fontSize: 14.sp, // Larger font size for better visibility
//           //                     fontWeight: FontWeight.bold,
//           //                     overflow: TextOverflow.ellipsis, // Prevent overflow
//           //                   ),
//           //                   maxLines: 2, // Limit the number of lines if necessary
//           //                 ),
//           //               ),
//           //             ],
//           //           ),
//           //         ),
//           //       );
//           //     },
//           //   ),
//           // ),
//
//           /// 7️⃣ LEFT DECOR
//           Positioned(
//             bottom: 0,
//             left: 0,
//             child: Image.asset(
//               'assets/images/left_corner_comp.png',
//               height: 140.h,
//             ),
//           ),
//
//           /// 8️⃣ RIGHT DECOR
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: Image.asset(
//               'assets/images/right_corner_comp.png',
//               width: 110.w,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// INDICATOR DOT
//   Widget circularDot(bool isActive) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 250),
//       margin: EdgeInsets.symmetric(horizontal: 4.w),
//       width: isActive ? 12.w : 10.w,
//       height: isActive ? 12.w : 10.w,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: Colors.grey.shade700,
//           width: 0.5,
//         ),
//       ),
//       child: isActive
//           ? Center(
//         child: Container(
//           width: 6.w,
//           height: 6.w,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: AppColors.primaryColor,
//           ),
//         ),
//       )
//           : null,
//     );
//   }
// }
//
// /// CURVE CLIPPER (SCALES WELL)
// class PerfectBottomCurveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, size.height - 95.h);
//     path.quadraticBezierTo(
//       size.width / 2,
//       size.height + 48.h,
//       size.width,
//       size.height - 95.h,
//     );
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
