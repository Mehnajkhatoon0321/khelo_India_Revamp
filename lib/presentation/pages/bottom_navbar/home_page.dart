import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';
import 'package:gms_application/core/widgets/flutter_animation.dart';
import 'package:gms_application/core/widgets/responsive_layout.dart';
import 'package:gms_application/core/widgets/select_competition_screen.dart';
import 'package:gms_application/presentation/pages/common_screen/about_screen.dart';
import 'package:gms_application/presentation/pages/common_screen/accred_centers_screen.dart';
import 'package:gms_application/presentation/pages/common_screen/faq.dart';
import 'package:gms_application/presentation/pages/common_screen/feedback_screen.dart';
import 'package:gms_application/presentation/pages/common_screen/gallery_screen.dart';
import 'package:gms_application/presentation/pages/common_screen/latest_news/latest_news.dart';
import 'package:gms_application/presentation/pages/common_screen/scoring_sections/scoring_screen.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/data/competition_list_data.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/venue.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageWithNavbarState();
}

class _HomePageWithNavbarState extends State<HomePage> {
  int selectedIndex = 0;

  /// 🔹 Main home response (can later come from API)
  final Map<String, dynamic> homeResponse = {
    "card": {
      "mascots": "assets/images/mascot.png",
      "gamesLogo": "assets/images/gamesNames.png",
      "gameName": "Khelo India Water Sports Festival Games 2026",
      "gamesDate": "05 Feb 2024 - 14 Feb 2024",
      "audioImage": "assets/images/audio_wave.png", // audio bar image
    },
    "sports": [
      {
        "title": "Ski Mountaineering",
        "date": "20th Jan 25 - 31st Jan 25",
        "image": "assets/images/featured.png"
      },
      {
        "title": "Alpine Skiing",
        "date": "20th Jan 25 - 31st Jan 25",
        "image": "assets/images/featured.png"
      },
      {
        "title": "Ski Mountaineering",
        "date": "20th Jan 25 - 31st Jan 25",
        "image": "assets/images/featured.png"
      },
      {
        "title": "Alpine Skiing",
        "date": "20th Jan 25 - 31st Jan 25",
        "image": "assets/images/featured.png"
      },
    ],
    "news": [
      {
        "image": "assets/images/news1.png",
        "title": "National Sports Championship Announcement"
      },
      {
        "image": "assets/images/news2.png",
        "title": "Winter Games Opening Ceremony"
      }
    ],
    "medalists": [
      {
        "name": "Jagdish Prasad",
        "university": "Dr. A.P.J. Abdul Kalam Technical University",
        "sport": "Ski Mountaineering",
        "image": "",
        "gold": 9,
        "silver": 2,
        "bronze": 0
      },
      {
        "name": "Jagdish Prasad",
        "university": "Dr. A.P.J. Abdul Kalam Technical University",
        "sport": "Ski Mountaineering",
        "image": "",
        "gold": 9,
        "silver": 2,
        "bronze": 0
      },
      {
        "name": "Jagdish Prasad",
        "university": "Dr. A.P.J. Abdul Kalam Technical University",
        "sport": "Ski Mountaineering fbhdfgbhfgbfggfgf",
        "image": "",
        "gold": 9,
        "silver": 2,
        "bronze": 0
      }
    ],
  };
  final List<Map<String, dynamic>> menuItems = [
    // {
    //   "id":1,
    //   "label": "Facial Verification",
    //   "image": "assets/images/about.png",
    // },
    // {
    //   "id":2,
    //   "label": "Athlete List",
    //   "image": "assets/images/about.png",
    // },
    {
      "id": 3,
      "label": "About",
      "image": "assets/images/about.png",
    },
    {
      "id": 4,
      "label": "Scoring",
      "image": "assets/images/scoring.png",
    },
    {
      "id": 5,
      "label": "AQI",
      "image": "assets/images/aqi.png",
    },
    {
      "id": 6,
      "label": "Top Medalist",
      "image": "assets/images/feedback.png",
    },
    // {
    //   "id":7,
    //   "label": "SSV List",
    //   "image": "assets/images/feedback.png",
    // }
  ];
  int _selectedCompetitionId = selectedCompetitionIdNotifier.value;
  final List<Map<String, dynamic>> explore = [
    {"id": 1, "title": "Accred Centers", "image": "assets/images/accred.png"},
    {"id": 2, "title": "Feedback", "image": "assets/images/feedback.png"},
    {"id": 3, "title": "Latest News", "image": "assets/images/latestNews.png"},
    {"id": 4, "title": "Venues", "image": "assets/images/venue.png"},
    {"id": 5, "title": "Gallery", "image": "assets/images/gallery.png"},
    {"id": 6, "title": "FAQ", "image": "assets/images/faq.png"},
  ];
  final ScrollController _menuScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    selectedCompetitionIdNotifier.addListener(_onCompetitionChanged);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (_menuScroll.hasClients && menuItems.length > 4) {
        _menuScroll.animateTo(
          12,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onCompetitionChanged() {
    if (!mounted) return;
    final int latestCompetitionId = selectedCompetitionIdNotifier.value;
    if (_selectedCompetitionId == latestCompetitionId) return;
    setState(() {
      _selectedCompetitionId = latestCompetitionId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final topCardHeight = (screenWidth * 0.52).clamp(178.0, 248.0);
    final topCardPadding = (screenWidth * 0.035).clamp(12.0, 20.0);
    final topLogoHeight = (screenWidth * 0.10).clamp(28.0, 48.0);
    final mascotMaxWidth = (screenWidth * 0.28).clamp(86.0, 220.0);
    final mascotHeight = (topCardHeight * 0.82).clamp(110.0, 190.0);

    final Map<String, dynamic> card =
        (homeResponse["card"] as Map<String, dynamic>);

    final List sports = (homeResponse["sports"] as List?) ?? <dynamic>[];
    final List newsList = (homeResponse["news"] as List?) ?? <dynamic>[];
    final List medalists = (homeResponse["medalists"] as List?) ?? <dynamic>[];

    return Scaffold(
      /// Outer background (visible above & below the main white card)
      backgroundColor: AppColors.whiteColors,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            /// 🔹 Scrollable Content
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        ResponsiveLayout.adaptiveHorizontalPadding(context),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      _buildTopHeader(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: _buildCompetitionSelector(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      // margin: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColors,
                        // borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  ResponsiveLayout.adaptiveHorizontalPadding(
                                      context),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 4.h),

                                ///home card design

                                Container(
                                  height: topCardHeight,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(25.r),
                                        child: Image.asset(
                                          "assets/images/home_card.png",
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(topCardPadding),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  if (card["gamesLogo"] !=
                                                          null &&
                                                      (card["gamesLogo"]
                                                              as String)
                                                          .isNotEmpty)
                                                    Image.asset(
                                                      card["gamesLogo"],
                                                      height: topLogoHeight,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  SizedBox(height: 10.h),
                                                  TrText(
                                                    card["gameName"] ?? "",
                                                    maxLines: screenWidth >= 700
                                                        ? 3
                                                        : 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: FTextStyle.heading,
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          screenHeight * 0.01),
                                                  TrText(
                                                    card["gamesDate"] ?? "",
                                                    style:
                                                        FTextStyle.subHeading,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            if (card["mascots"] != null &&
                                                (card["mascots"] as String)
                                                    .isNotEmpty)
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: mascotMaxWidth,
                                                  maxHeight: mascotHeight,
                                                ),
                                                child: Image.asset(
                                                  card["mascots"],
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ).animation.fadeScale(),

                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TrText(
                                      "For you",
                                      style:
                                          FTextStyle.textSecBlackStylePrimary,
                                    ),

                                    const SizedBox(height: 12),
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        final spacing = 10.0;
                                        final visibleItems =
                                            menuItems.length >= 4
                                                ? 4
                                                : menuItems.length;

                                        final totalSpacing =
                                            spacing * (visibleItems - 1);
                                        final itemWidth =
                                            (constraints.maxWidth -
                                                    totalSpacing) /
                                                visibleItems;

                                        final itemHeight = itemWidth + 18;

                                        /// ⭐ CARD BUILDER
                                        Widget buildCard(
                                            Map<String, dynamic> item,
                                            int index) {
                                          final isLastVisible = index == 3 &&
                                              menuItems.length > 4;

                                          Widget card = SizedBox(
                                            width: itemWidth,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(14.r),
                                                onTap: () => _navigateFromMenu(
                                                    item["id"]),
                                                child: Ink(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14.r),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFFE9E9E9)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(.05),
                                                        blurRadius: 14,
                                                        offset:
                                                            const Offset(0, 5),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8.h,
                                                            horizontal: 6.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height:
                                                              itemWidth * .40,
                                                          width:
                                                              itemWidth * .40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .primaryColor
                                                                .withOpacity(
                                                                    .08),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Image.asset(
                                                            item["image"],
                                                            height:
                                                                itemWidth * .20,
                                                          ),
                                                        ),
                                                        SizedBox(height: 6.h),
                                                        TrText(
                                                          item["label"] ?? "",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: FTextStyle
                                                              .chipText
                                                              .copyWith(
                                                                  height: 1.1),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );

                                          /// ⭐ scroll hint animation
                                          if (isLastVisible) {
                                            card = card.animation
                                                .horizontalLoop(
                                                    begin: -4, end: 4);
                                          }

                                          return card;
                                        }

                                        /// ⭐ ≤4 items → Row (perfect alignment)
                                        if (menuItems.length <= 4) {
                                          return SizedBox(
                                            height: itemHeight,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: List.generate(
                                                menuItems.length,
                                                (index) => buildCard(
                                                    menuItems[index], index),
                                              ),
                                            ),
                                          );
                                        }

                                        /// ⭐ >4 items → Scrollable
                                        return SizedBox(
                                          height: itemHeight,
                                          child: Stack(
                                            children: [
                                              ListView.separated(
                                                controller: _menuScroll,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: menuItems.length,
                                                separatorBuilder: (_, __) =>
                                                    const SizedBox(width: 10),
                                                itemBuilder: (context, index) =>
                                                    buildCard(menuItems[index],
                                                        index),
                                              ),

                                              /// ⭐ gradient scroll hint
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                child: IgnorePointer(
                                                  child: Container(
                                                    width: 28,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
                                                        colors: [
                                                          Colors.white
                                                              .withOpacity(0),
                                                          Colors.white,
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(
                                      height: 30,
                                    ),
                                    TrText(
                                      "Explore Games",
                                      style:
                                          FTextStyle.textSecBlackStylePrimary,
                                    ),
                                    SizedBox(height: 20.h),
                                    Wrap(
                                      alignment: WrapAlignment.start,
                                      runAlignment: WrapAlignment.start,
                                      spacing: 10,
                                      runSpacing: 12,
                                      children: explore.map((item) {
                                        final int id =
                                            (item["id"] as int?) ?? -1;

                                        return Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(24.r),
                                            onTap: () =>
                                                _navigateFromExplore(id),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 10.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.r),
                                                border: Border.all(
                                                  color: const Color(0xFFD6D8DE),
                                                  width: 1.15,
                                                ),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0x12000000),
                                                    offset: Offset(0, 3),
                                                    blurRadius: 8,
                                                    spreadRadius: -1,
                                                  ),
                                                  BoxShadow(
                                                    color: Color(0x7AFFFFFF),
                                                    offset: Offset(0, 1),
                                                    blurRadius: 0,
                                                  ),
                                                ],
                                              ),
                                              child: Stack(
                                                children: [
                                                  Positioned.fill(
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.r),
                                                        gradient: LinearGradient(
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                          colors: [
                                                            _exploreChipTint(id),
                                                            Colors.white
                                                                .withOpacity(0),
                                                          ],
                                                          stops: const [0.0, 0.58],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Image.asset(
                                                        item["image"],
                                                        height: 18,
                                                        width: 18,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      TrText(
                                                        item["title"],
                                                        style: FTextStyle.chipText
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 9.8.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),

                                    ///Featured Sports
                                    TrText(
                                      "Featured Sports ",
                                      style:
                                          FTextStyle.textSecBlackStylePrimary,
                                    ),
                                    SizedBox(height: 20.h),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                              .size
                                              .width *
                                          .39, // ⭐ little more breathing space

                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        itemCount: sports.length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(width: 12),
                                        itemBuilder: (context, index) {
                                          final sport = sports[index];

                                          final cardWidth =
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .4;

                                          return Container(
                                            width: cardWidth,
                                            padding: EdgeInsets.all(12.w),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(19.r),
                                              border:
                                                  const Border.fromBorderSide(
                                                BorderSide(
                                                    color: Color(0xFFD9D9D9),
                                                    width: 1),
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0x14000000),
                                                  offset: Offset(3, 1),
                                                  blurRadius: 7,
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const SizedBox(height: 6),

                                                /// ⭐ icon
                                                Container(
                                                  height: 44.sp,
                                                  width: 44.sp,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                    sport["image"],
                                                    height: 22.sp,
                                                    width: 22.sp,
                                                  ),
                                                ),

                                                const Spacer(), // ⭐ auto spacing like figma

                                                TrText(
                                                  sport["title"],
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      FTextStyle.cardTileText,
                                                ),

                                                const SizedBox(height: 6),

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/schedule.png",
                                                      height: 10.sp,
                                                      width: 10.sp,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Expanded(
                                                      child: TrText(
                                                        sport["date"],
                                                        style: FTextStyle
                                                            .datePicker,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 6),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),

                                    ///Event News
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TrText(
                                          "Event News",
                                          style: FTextStyle
                                              .textSecBlackStylePrimary,
                                        ),
                                        TrText(
                                          "View All",
                                          style:
                                              FTextStyle.privacyPolicyTxtStyle,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Builder(
                                      builder: (context) {
                                        final limitedNews =
                                            newsList.take(2).toList(growable: false);
                                        return SizedBox(
                                          height:
                                              MediaQuery.of(context).size.width *
                                                  .52,
                                          child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        itemCount: limitedNews.length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(width: 12),
                                        itemBuilder: (context, index) {
                                          final news = limitedNews[index];

                                          final cardWidth =
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45;
                                          final cardHeight = cardWidth * 1.06;

                                          return Container(
                                            width: cardWidth,
                                            height: cardHeight,
                                            padding: EdgeInsets.all(12.w),
                                            decoration: BoxDecoration(
                                              color: Colors.white,

                                              /// ⭐ figma radius
                                              borderRadius:
                                                  BorderRadius.circular(19.r),

                                              /// ⭐ exact figma border
                                              border:
                                                  const Border.fromBorderSide(
                                                BorderSide(
                                                    color: Color(0xFFD9D9D9),
                                                    width: 1),
                                              ),

                                              /// ⭐ exact figma shadow (VERY IMPORTANT)
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(
                                                      0x14000000), // 8% black
                                                  offset: Offset(3, 1),
                                                  blurRadius: 7,
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                            ),
                                            // decoration: BoxDecoration(
                                            //   color: Colors.white,
                                            //   borderRadius: BorderRadius.circular(20.r), // radius 20px
                                            //   boxShadow: const [
                                            //     BoxShadow(
                                            //       color: Color(0x14000000), // #000000 with 8% opacity
                                            //       blurRadius: 74,            // Figma blur 74
                                            //       offset: Offset(9, 21),     // Figma X=9, Y=21
                                            //       spreadRadius: 0,
                                            //     ),
                                            //   ],
                                            // ),

                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                /// ⭐ IMAGE WITH FALLBACK
                                                Center(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    child: news["image"] !=
                                                                null &&
                                                            news["image"]
                                                                .toString()
                                                                .isNotEmpty
                                                        ? Image.asset(
                                                            news["image"],
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.41, // ⭐ 156 dynamic
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.26, // ⭐ 100 dynamic
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (_, __, ___) =>
                                                                    Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.41,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.26,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        : Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.41,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.26,
                                                            color: Colors.black,
                                                          ),
                                                  ),
                                                ),

                                                const SizedBox(height: 10),

                                                /// ⭐ TITLE
                                                TrText(
                                                  news["title"],
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: FTextStyle.cardTileText
                                                      .copyWith(
                                                          fontSize: 10.sp),
                                                ),

                                                const Spacer(),

                                                /// ⭐ EXPLORE BUTTON
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    TrText("Explore",
                                                        style: FTextStyle
                                                            .cardTileText
                                                            .copyWith(
                                                                fontSize: 10.sp,
                                                                color: AppColors
                                                                    .primaryColor)),
                                                    const SizedBox(width: 4),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 2.0,
                                                      ),
                                                      child: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: 10,
                                                          color: AppColors
                                                              .primaryColor),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 8,
                                                )
                                              ],
                                            ),
                                          );
                                          },
                                        ),
                                        );
                                      },
                                    ),

                                    SizedBox(
                                      height: 30,
                                    ),

                                    ///Medalist

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TrText(
                                          "Top Medalists",
                                          style: FTextStyle
                                              .textSecBlackStylePrimary,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            /// 👉 navigate next page
                                          },
                                          child: TrText(
                                            "View All",
                                            style: FTextStyle
                                                .privacyPolicyTxtStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: screenWidth *
                                          .52, // ⭐ corrected list height
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        itemCount: medalists.length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(width: 12),
                                        itemBuilder: (context, index) {
                                          final m = medalists[index];

                                          final cardWidth = screenWidth * .40;
                                          final cardHeight = cardWidth * 1.28;
                                          final imageSize = cardWidth * .4;

                                          return Container(
                                            width: cardWidth,
                                            height: cardHeight,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              child: Stack(
                                                children: [
                                                  /// ⭐ Background
                                                  Positioned.fill(
                                                    child: Image.asset(
                                                      "assets/images/backgroundmedal.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  /// ⭐ Overlay
                                                  Positioned.fill(
                                                    child: Container(
                                                      color: Colors.black
                                                          .withOpacity(.15),
                                                    ),
                                                  ),

                                                  /// ⭐ Content
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w,
                                                            vertical: 12.h),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        /// 🔥 Top Row
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            /// Athlete image
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.r),
                                                              child: Container(
                                                                height:
                                                                    imageSize,
                                                                width:
                                                                    imageSize,
                                                                color: Colors
                                                                    .white,
                                                                child: (m["image"] !=
                                                                            null &&
                                                                        m["image"]
                                                                            .toString()
                                                                            .isNotEmpty)
                                                                    ? Image.asset(
                                                                        m[
                                                                            "image"],
                                                                        fit: BoxFit
                                                                            .cover)
                                                                    : const Icon(
                                                                        Icons
                                                                            .person),
                                                              ),
                                                            ),

                                                            const SizedBox(
                                                                width: 14),

                                                            /// Medal count
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  _medal(
                                                                      "assets/images/gold.png",
                                                                      m["gold"]),
                                                                  const SizedBox(
                                                                      height:
                                                                          3),
                                                                  _medal(
                                                                      "assets/images/silver.png",
                                                                      m["silver"]),
                                                                  const SizedBox(
                                                                      height:
                                                                          3),
                                                                  _medal(
                                                                      "assets/images/bronze.png",
                                                                      m["bronze"]),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        const SizedBox(
                                                            height: 10),

                                                        /// Name
                                                        TrText(
                                                          m["name"] ?? "",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: FTextStyle
                                                              .medalSub
                                                              .copyWith(
                                                            fontSize: 11,
                                                            color: AppColors
                                                                .whiteColors,
                                                          ),
                                                        ),

                                                        const SizedBox(
                                                            height: 4),

                                                        /// University
                                                        TrText(
                                                          m["university"] ?? "",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: FTextStyle
                                                              .medalSub,
                                                        ),

                                                        const Spacer(), // ⭐ pushes sport chip down (fix gap)

                                                        /// Sport chip
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.w,
                                                                  vertical:
                                                                      4.h),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.r),
                                                          ),
                                                          child: TrText(
                                                            m["sport"] ?? "",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: FTextStyle
                                                                .navbarSelected
                                                                .copyWith(
                                                              fontSize: 8,
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50.withOpacity(0.1),
                              // borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// 🔹 Bottom Grey Gradient (Above Navbar)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0x22000000),
                        // Color(0x44000000),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Image.asset(
              "assets/images/login.png",
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.content_paste, size: 18),
            ),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "Welcome To ", style: FTextStyle.helloTxt),
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 20,
              ),
            ),
            Positioned(
              right: 12.w,
              top: 10.h,
              child: Container(
                width: 6.w,
                height: 6.w,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompetitionSelector() {
    return GestureDetector(
      onTap: _openCompetitionSheet,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TrText(
              _selectedCompetitionId > 0
                  ? getCompetitionLabelById(_selectedCompetitionId)
                  : 'Select Competition',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: FTextStyle.helloTxt.copyWith(fontSize: 14.sp),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: Color(0xFF2E3142),
          ),
        ],
      ),
    );
  }

  Widget _medal(String image, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          image,
          height: 16,
          width: 16,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 4),
        TrText(
          count.toString().padLeft(2, '0'),
          style: FTextStyle.medalSub.copyWith(
            color: AppColors.whiteColors,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        )
      ],
    );
  }

  Color _exploreChipTint(int id) {
    switch (id) {
      case 1:
        return const Color(0xFFF1F7FF);
      case 2:
        return const Color(0xFFFFF2F9);
      case 3:
        return const Color(0xFFF2F3FF);
      case 4:
        return const Color(0xFFFFF5EE);
      case 5:
        return const Color(0xFFFFFAED);
      case 6:
        return const Color(0xFFF0FAF4);
      default:
        return const Color(0xFFF7F7F7);
    }
  }

  void _navigateFromMenu(int id) {
    if (id == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AboutScreen()),
      );
    } else if (id == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ScoringScreen()),
      );
    } else if (id == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AboutScreen()),
      );
    } else if (id == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AboutScreen()),
      );
    } else {
      debugPrint("No screen mapped");
    }
  }

  void _navigateFromExplore(int id) {
    if (id == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AccredCentersScreen()),
      );
    } else if (id == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const FeedbackScreen()),
      );
    } else if (id == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LatestNewsScreen()),
      );
    } else if (id == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Venue()),
      );
    } else if (id == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const GalleryScreen()),
      );
    } else if (id == 6) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const FaqScreen()),
      );
    } else {
      debugPrint("No explore screen mapped");
    }
  }

  Future<void> _openCompetitionSheet() async {
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
  }

  @override
  void dispose() {
    selectedCompetitionIdNotifier.removeListener(_onCompetitionChanged);
    super.dispose();
  }
}
