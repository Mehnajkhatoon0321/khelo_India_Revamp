import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';
import 'package:gms_application/core/widgets/select_competition_screen.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/data/competition_list_data.dart';
import 'package:gms_application/presentation/pages/onboarding_screen/privacy_policy.dart';

class CompetitionSelectionScreen extends StatefulWidget {
  const CompetitionSelectionScreen({super.key});

  @override
  State<CompetitionSelectionScreen> createState() =>
      _CompetitionSelectionScreenState();
}

class _CompetitionSelectionScreenState
    extends State<CompetitionSelectionScreen> {
  final SimpleTranslator _translator = SimpleTranslator.instance;
  late String _selectedDropdownLanguage;
  int _selectedCompetitionId = selectedCompetitionIdNotifier.value;
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
    _selectedDropdownLanguage = SimpleTranslator.dropdownLabelForLanguage(
      _translator.selectedLanguage.value,
    );

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
              color: AppColors.whiteColors,
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

          // Positioned(
          //   top: MediaQuery.of(context).padding.top + 8,
          //   left: 20.w,
          //   right: 20.w,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: <Widget>[
          //       Container(
          //         padding: const EdgeInsets.symmetric(horizontal: 12),
          //         decoration: BoxDecoration(
          //           color: AppColors.whiteColors.withOpacity(0.94),
          //           borderRadius: BorderRadius.circular(24),
          //         ),
          //         child: DropdownButtonHideUnderline(
          //           child: DropdownButton<String>(
          //             value: _selectedDropdownLanguage,
          //             icon: const Icon(Icons.language),
          //             items: SimpleTranslator.dropdownLanguages
          //                 .map((String langLabel) {
          //               return DropdownMenuItem<String>(
          //                 value: langLabel,
          //                 child: Text(
          //                   langLabel,
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //               );
          //             }).toList(),
          //             onChanged: (String? value) async {
          //               if (value == null) return;
          //               setState(() {
          //                 _selectedDropdownLanguage = value;
          //               });
          //
          //               final TranslateLanguage? mlKitLanguage =
          //                   SimpleTranslator.languageFromDropdown(value);
          //               if (mlKitLanguage == null) {
          //                 if (!mounted) return;
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   SnackBar(
          //                     content: Text(
          //                       '$value is not supported by ML Kit translation yet.',
          //                     ),
          //                   ),
          //                 );
          //                 return;
          //               }
          //
          //               await _translator.setLanguage(mlKitLanguage);
          //             },
          //           ),
          //         ),
          //       ),
          //       ValueListenableBuilder<bool>(
          //         valueListenable: _translator.isDownloadingModel,
          //         builder: (_, downloading, __) {
          //           if (!downloading) return const SizedBox.shrink();
          //           return Padding(
          //             padding: EdgeInsets.only(top: 6.h, right: 4.w),
          //             child: const SizedBox(
          //               width: 16,
          //               height: 16,
          //               child: CircularProgressIndicator(strokeWidth: 2),
          //             ),
          //           );
          //         },
          //       ),
          //     ],
          //   ),
          // ),

          //  DESCRIPTION TEXT
          Positioned(
            top: 0.52.sh,
            left: 24.w,
            right: 24.w,
            child: TrText(
              'Sports and fitness are vital to a healthy life. The Khelo India Programme promotes sports at the grassroots, aiming to make India a global leader in sports.',
              textAlign: TextAlign.center,
              style: FTextStyle.competitionDescriptionStyle.copyWith(
                color: AppColors.whiteColors.withOpacity(0.9),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.70,
            left: 24,
            right: 24,
            child: GestureDetector(
              onTap: () async {
                final int? selectedId = await openSelectCompetitionBottomSheet(
                  context: context,
                  selectedCompetitionId: _selectedCompetitionId,
                  competitions: kCompetitionList,
                );

                if (!mounted || selectedId == null) return;
                setState(() {
                  _selectedCompetitionId = selectedId;
                });
                selectedCompetitionIdNotifier.value = selectedId;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PrivacyPolicy(),
                  ),
                );
              },
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border:
                      Border.all(color: AppColors.whiteColors.withOpacity(0.6)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder<TranslateLanguage>(
                        valueListenable: _translator.selectedLanguage,
                        builder: (_, __, ___) {
                          return TrText(
                            getCompetitionLabelById(_selectedCompetitionId),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: FTextStyle.competitionButtonStyle.copyWith(
                              fontSize: 14.sp,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.whiteColors,
                    ),
                  ],
                ),
              ),
            ),
          ),

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
          color: AppColors.scheduleMetaText,
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
