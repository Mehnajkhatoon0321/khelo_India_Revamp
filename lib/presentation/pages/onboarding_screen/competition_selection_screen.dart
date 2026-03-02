
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/presentation/pages/onboarding_screen/privacy_policy.dart';

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
    'assets/images/competition_second.png',
    'assets/images/comptetion.png',

    'assets/images/competition_third.png',


  ];
  final List<Map<String, String>> competitionNameImages = [
    {
      "image": 'assets/images/comptetion.png',
      "gameName": "University Games \n2025",
    },
    {
      "image": 'assets/images/khelo.png',
      "gameName": "Youth Games \n 2025",
    },
    {

      "image": 'assets/images/khelo.png',
      "gameName": "Youth Games 2025",
    },
  ];


  @override
  void initState() {
    super.initState();

    // Set the system UI to immersive sticky mode (full-screen)
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );

    // Start the auto-scroll for the image slider
    _startAutoScroll();

    // Listen for page changes to update the current index and indicator
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page?.round() ?? 0;
      });
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _currentIndex = (_currentIndex + 1) % competitionImages.length;

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
    return Scaffold(
      body: Stack(
        children: [
          // PURPLE BACKGROUND
           Container(color: AppColors.primaryColor),
           // Container(color:Color(0xFF000000)),


          //  WHITE CURVE
          ClipPath(
            clipper: PerfectBottomCurveClipper(),
            child: Container(
              height: 0.48.sh,
              color: Colors.white,
            ),
          ),

          //  IMAGE SLIDER
          Positioned(
            top: 0.h,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 270.h, // Adjust height for different screen sizes
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

          // INDICATOR
          Positioned(
            top: 0.39.sh,
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

          //  DESCRIPTION TEXT
          Positioned(
            top: 0.52.sh,
            left: 24.w,
            right: 24.w,
            child: Text(
              "Sports and fitness are vital to a healthy life. The Khelo India Programme promotes sports at the grassroots, aiming to make India a global leader in sports.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                height: 2,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.9),
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.70,
            left: 24,
            right: 24,
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>  PrivacyPolicy(),
                                      ),
                                    );
              },
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.6)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Select Games",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 0.64.sh,
          //   left: 10.w,
          //   right: 10.w,
          //   child: SizedBox(
          //     height: 130.h,
          //     child: Center(
          //       child: SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         physics: competitionNameImages.length <= 2
          //             ? const NeverScrollableScrollPhysics()
          //             : const BouncingScrollPhysics(),
          //         child: Row(
          //           mainAxisAlignment: competitionNameImages.length <= 2
          //               ? MainAxisAlignment.center
          //               : MainAxisAlignment.start,
          //           children: List.generate(
          //             competitionNameImages.length,
          //                 (index) {
          //               final item = competitionNameImages[index];
          //               final count = competitionNameImages.length;
          //
          //               // 🎯 Dynamic width
          //               double cardWidth;
          //               if (count == 1) {
          //                 cardWidth = 0.65.sw;
          //               } else
          //                 if (count == 2) {
          //                 cardWidth = 0.42.sw;
          //               } else {
          //                 cardWidth = 125.w;
          //               }
          //
          //               return GestureDetector(
          //                 onTap: () {
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (_) =>  PrivacyPolicy(),
          //                     ),
          //                   );
          //                 },
          //                 child: Card(
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(20.r),
          //                   ),
          //                   elevation: count <= 2 ? 10 : 8,
          //                   shadowColor: Colors.black.withOpacity(0.3),
          //                   margin: EdgeInsets.symmetric(
          //                     horizontal: count <= 2 ? 6.w : 6.w,
          //                   ),
          //                  child: Container(
          //                   width: cardWidth,
          //                   padding: EdgeInsets.all(8.w),
          //                   child: Column(
          //                     children: [
          //                       // 🖼️ Fixed Image Area
          //                       SizedBox(
          //                         height: 70.h, // SAME for all cards
          //                         child: Center(
          //                           child: ClipRRect(
          //                             borderRadius: BorderRadius.circular(30.r),
          //                             child: Container(
          //
          //                               child: Padding(
          //                                 padding: const EdgeInsets.all(18.0),
          //                                 child: Image.asset(
          //                                   item["image"]!,
          //                                   height: count <= 2 ? 40.h : 40.h,
          //                                   width: count <= 2 ? 40.w : 40.w,
          //                                   fit: BoxFit.cover,
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //
          //                       SizedBox(height: 8.h),
          //
          //                       // 📝 Fixed Text Start Position
          //                       SizedBox(
          //                         height: 32.h, // reserves space for 2 lines
          //                         child: Align(
          //                           alignment: Alignment.topCenter,
          //                           child: Text(
          //                             item["gameName"]!,
          //                             textAlign: TextAlign.center,
          //                             style: TextStyle(
          //                               fontSize: 13.sp,
          //                               fontWeight: FontWeight.w700,
          //                               color: Colors.black.withOpacity(0.85),
          //                             ),
          //                             maxLines: 2,
          //                             overflow: TextOverflow.ellipsis,
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //
          //               ),
          //               );
          //             },
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),


          // Positioned(
          //   top: 0.64.sh,
          //   left: 10.w,
          //   right: 10.w,
          //   child: SizedBox(
          //     height: 130.h,
          //     child: Center(
          //       child: SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Row(
          //           children: List.generate(
          //             competitionNameImages.length,
          //                 (index) {
          //               final item = competitionNameImages[index];
          //
          //               return GestureDetector(
          //                 onTap: () {
          //                   debugPrint('Selected ${item["gameName"]}');
          //                 },
          //                 child: Card(
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(16.r),
          //                   ),
          //                   elevation: 8,
          //                   shadowColor: Colors.black.withOpacity(0.25),
          //                   margin: EdgeInsets.only(right: 12.w),
          //                   child: Container(
          //                     width: 125.w,
          //                     padding: EdgeInsets.all(8.w),
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         ClipRRect(
          //                           borderRadius: BorderRadius.circular(12.r),
          //                           child: Image.asset(
          //                             item["image"]!,
          //                             height: 70.h,
          //                             width: 70.w,
          //                             fit: BoxFit.cover,
          //                           ),
          //                         ),
          //                         SizedBox(height: 6.h),
          //                         Text(
          //                           item["gameName"]!,
          //                           textAlign: TextAlign.center,
          //                           style: TextStyle(
          //                             fontSize: 13.sp,
          //                             fontWeight: FontWeight.w600,
          //                             color: Colors.black.withOpacity(0.75),
          //                           ),
          //                           maxLines: 2,
          //                           overflow: TextOverflow.ellipsis,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),


          // 7️⃣ LEFT DECOR
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/left_corner_comp.png',
              height: 140.h,
            ),
          ),

          // 8️⃣ RIGHT DECOR
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/right_corner_comp.png',
              width: 110.w,
            ),
          ),
        ],
      ),
    );
  }

  // INDICATOR DOT
  Widget circularDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: isActive ? 12.w : 10.w,
      height: isActive ? 12.w : 10.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.shade700,
          width: 0.5,
        ),
      ),
      child: isActive
          ? Center(
        child: Container(
          width: 6.w,
          height: 6.w,
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

/// CURVE CLIPPER (SCALES WELL)
class PerfectBottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 95.h);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 48.h,
      size.width,
      size.height - 95.h,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
