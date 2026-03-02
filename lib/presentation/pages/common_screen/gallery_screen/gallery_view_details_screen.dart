import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageWithNavbarState();
}

class _HomePageWithNavbarState extends State<HomePage> {
  int selectedIndex = 0;

  final Map<String, dynamic> homepage = {
    "card": {
      "mascots": "assets/images/mascot.png",
      "gamesLogo": "assets/images/gamesNames.png",
      "gameName": "Khelo India Water Sports Festival Games 2026",
      "gamesDate": "05 Feb 2024 - 14 Feb 2024",
    },



  };

  final List<Map<String, dynamic>> menuItems = [
    {
      "id":1,
      "label": "Score",
      "image": "assets/images/home.png",
    },
    {
      "id":2,
      "label": "Schedule",
      "image": "assets/images/schedule.png",
    },
    {
      "id":3,
      "label": "About",
      "image": "assets/images/venue.png",
    },
    {
      "id":4,
      "label": "Accred Centers",
      "image": "assets/images/login.png",
    },


  ];

  List exploreItems = [
    {"title": "Accred Centers", "image": "assets/images/accred.png"},
    {"title": "Feedback", "image": "assets/images/feedback.png"},
    {"title": "Latest News", "image": "assets/images/latestNews.png"},
    {"title": "Gallery", "image": "assets/images/gallery.png"},
    {"title": "FAQ", "image": "assets/images/faq.png"},
    {"title": "Venues", "image": "assets/images/venue.png"},



  ];

  List sports = [
    {"title": "Ski Mountaineering", "date": "20th Jan 25 - 31st Jan 25", "image": "assets/images/featured.png"},
    {"title": "Alpine Skiing", "date": "20th Jan 25 - 31st Jan 25", "image": "assets/images/featured.png"},
    {"title": "Alpine Skiing", "date": "20th Jan 25 - 31st Jan 25", "image": "assets/images/featured.png"},
    {"title": "Alpine Skiing", "date": "20th Jan 25 - 31st Jan 25", "image": "assets/images/featured.png"},
  ];


  List newsList = [
    {
      "image": "assets/images/news1.png",
      "title": "Dr. Niraj K. Pawan, Chairman, Rajasthan State",
    },
    {
      "image": "assets/images/news2.png",
      "title": "National Sports Championship Announcement",
    },
  ];

  List medalists = [
    {
      "name": "Jagdish Prasad",
      "university": "Dr. A.P.J. Abdul Kalam Technical University",
      "sport": "Ski Mountaineering",
      "image": "",
      "gold": 9,
      "silver": 2,
      "bronze": 0,
    },
    {
      "name": "Jagdish Prasad",
      "university": "Dr. A.P.J. Abdul Kalam Technical University",
      "sport": "Ski Mountaineering",
      "image": "",
      "gold": 9,
      "silver": 2,
      "bronze": 0,
    },
    {
      "name": "Jagdish Prasad",
      "university": "Dr. A.P.J. Abdul Kalam Technical University",
      "sport": "Ski Mountaineering",
      "image": "",
      "gold": 9,
      "silver": 2,
      "bronze": 0,
    }, {
      "name": "Jagdish Prasad",
      "university": "Dr. A.P.J. Abdul Kalam Technical University",
      "sport": "Ski Mountaineering",
      "image": "",
      "gold": 9,
      "silver": 2,
      "bronze": 0,
    }, {
      "name": "Jagdish Prasad",
      "university": "Dr. A.P.J. Abdul Kalam Technical University",
      "sport": "Ski Mountaineering",
      "image": "",
      "gold": 9,
      "silver": 2,
      "bronze": 0,
    }, {
      "name": "Jagdish Prasad",
      "university": "Dr. A.P.J. Abdul Kalam Technical University",
      "sport": "Ski Mountaineering",
      "image": "",
      "gold": 9,
      "silver": 2,
      "bronze": 0,
    }, {
      "name": "Jagdish Prasad",
      "university": "Dr. A.P.J. Abdul Kalam Technical University",
      "sport": "Ski Mountaineering",
      "image": "",
      "gold": 9,
      "silver": 2,
      "bronze": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final listHeight = screenWidth * .51;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColors,
        body: Stack(
          children: [

            /// 🔹 Scrollable Content
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    // padding: const EdgeInsets.only(bottom: 100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [

                          SizedBox(height: 20,),
                          Row(
                            children: [

                              /// Profile Image
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/profile_image.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 14),

                              /// Hello Text
                              Expanded(
                                child: RichText(
                                  text:  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "Hello   ",
                                          style:FTextStyle.privacyDecTxt.copyWith(color: AppColors.textPrimary,)
                                      ),
                                      TextSpan(
                                        text: "Johnson!",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2E3142),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              /// Notification Bell
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.notifications_none_rounded,
                                      size: 20,
                                    ),
                                  ),

                                  /// Red Dot
                                  Positioned(
                                    right: 12,
                                    top: 12,
                                    child: Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          /// 🔹 Responsive Card
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20),
                            child: Container(
                              height: screenHeight * 0.25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                children: [

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      "assets/images/home_card.png",
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(screenWidth * 0.04),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                homepage["card"]["gamesLogo"],
                                                height:
                                                screenHeight * 0.07,
                                              ),
                                              SizedBox(height: 10,),
                                              Text(
                                                homepage["card"]["gameName"],
                                                maxLines: 2,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: FTextStyle.heading,
                                              ),
                                              SizedBox(
                                                  height:
                                                  screenHeight * 0.01),
                                              Text(
                                                homepage["card"]
                                                ["gamesDate"],
                                                style:
                                                FTextStyle.subHeading,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          homepage["card"]["mascots"],
                                          height:
                                          screenHeight * 0.18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "For you",
                                style: FTextStyle.textSecBlackStylePrimary,
                              ),

                              const SizedBox(height: 10),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: menuItems.length >= 4 ? 4 : menuItems.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 9,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 0.8,
                                ),
                                itemBuilder: (context, index) {
                                  final item = menuItems[index];

                                  return GestureDetector(
                                    onTap: () {

                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteOffColors,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center, // ⭐ centered
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 10),
                                          /// image zone
                                          Center(
                                            child: SizedBox(
                                              height: 20.sp,
                                              width: 20.sp,
                                              child: Image.asset(item["image"]),
                                            ),
                                          ),

                                          const SizedBox(height: 12),

                                          /// text zone
                                          SizedBox(
                                            height: 28.sp,
                                            child: Text(
                                              item["label"] ?? "",
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: FTextStyle.chipText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 30,),
                              Text(
                                "Explore Games",
                                style: FTextStyle.textSecBlackStylePrimary,
                              ),
                              SizedBox(height: 20,),
                              Wrap(
                                alignment: WrapAlignment.start,

                                runAlignment: WrapAlignment.start,
                                spacing: 5,
                                runSpacing: 10,
                                children: exploreItems.map((item) {
                                  return Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF37003C), Color(0xFFD967B1)],
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          /// ⭐ Image instead of Icon
                                          Image.asset(
                                            item["image"],
                                            height: 14,
                                            width: 14,
                                            fit: BoxFit.contain,
                                          ),

                                          const SizedBox(width: 8),

                                          Text(
                                            item["title"],
                                            style: FTextStyle.chipText,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 30,),

                              ///Featured Sports
                              Text(
                                "Featured Sports ",
                                style: FTextStyle.textSecBlackStylePrimary,
                              ),
                              SizedBox(height: 20,),
                              SizedBox(
                                height: MediaQuery.of(context).size.width * .4, // ⭐ little more breathing space

                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  itemCount: sports.length,
                                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    final sport = sports[index];

                                    final cardWidth = MediaQuery.of(context).size.width * .4;

                                    return Container(
                                      width: cardWidth,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,

                                        /// ⭐ figma radius
                                        borderRadius: BorderRadius.circular(19),

                                        /// ⭐ exact figma border
                                        border: const Border.fromBorderSide(
                                          BorderSide(color: Color(0xFFD9D9D9), width: 1),
                                        ),

                                        /// ⭐ exact figma shadow (VERY IMPORTANT)
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x14000000), // 8% black
                                            offset: Offset(3, 1),
                                            blurRadius: 7,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(height: 6),
                                          /// ⭐ icon
                                          Container(
                                            height: 44.sp,
                                            width: 44.sp,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.primaryColor,
                                            ),
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              sport["image"],
                                              height: 22.sp,
                                              width: 22.sp,
                                            ),
                                          ),

                                          const Spacer(), // ⭐ auto spacing like figma

                                          Text(
                                            sport["title"],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: FTextStyle.cardTileText,
                                          ),

                                          const SizedBox(height: 6),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                "assets/images/schedule.png",
                                                height: 10.sp,
                                                width: 10.sp,
                                              ),
                                              const SizedBox(width: 4),

                                              Expanded(
                                                child: Text(
                                                  sport["date"],
                                                  style: FTextStyle.datePicker,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
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
                              SizedBox(height: 30,),
                              ///Event News
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Event News",
                                    style: FTextStyle.textSecBlackStylePrimary,
                                  ),Text(
                                    "View All",
                                    style: FTextStyle.privacyPolicyTxtStyle,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20,),
                              SizedBox(
                                height: MediaQuery.of(context).size.width * .52,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(horizontal: 2),
                                  itemCount: newsList.take(2).length,
                                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    final news = newsList[index];

                                    final cardWidth = MediaQuery.of(context).size.width * 0.45;
                                    final cardHeight = cardWidth * 1.06;

                                    return Container(
                                      width: cardWidth,
                                      height: cardHeight,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x14000000),
                                            blurRadius: 7,
                                            offset: Offset(3, 6),
                                          ),
                                        ],
                                      ),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          /// ⭐ IMAGE WITH FALLBACK
                                          Center(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: news["image"] != null && news["image"].toString().isNotEmpty
                                                  ? Image.asset(
                                                news["image"],
                                                width: MediaQuery.of(context).size.width * 0.41,   // ⭐ 156 dynamic
                                                height: MediaQuery.of(context).size.width * 0.26,  // ⭐ 100 dynamic
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) => Container(
                                                  width: MediaQuery.of(context).size.width * 0.41,
                                                  height: MediaQuery.of(context).size.width * 0.26,
                                                  color: Colors.black,
                                                ),
                                              )
                                                  : Container(
                                                width: MediaQuery.of(context).size.width * 0.41,
                                                height: MediaQuery.of(context).size.width * 0.26,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          /// ⭐ TITLE
                                          Text(
                                            news["title"],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: FTextStyle.cardTileText.copyWith(fontSize: 10.sp),
                                          ),

                                          const Spacer(),

                                          /// ⭐ EXPLORE BUTTON
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "Explore",
                                                  style: FTextStyle.cardTileText.copyWith(fontSize: 10.sp,color: AppColors.primaryColor)
                                              ),
                                              const SizedBox(width: 4),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 2.0,),
                                                child: Icon(Icons.arrow_forward_ios,
                                                    size: 10, color: AppColors.primaryColor),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 8,)
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),


                              SizedBox(height: 30,),
                              ///Medalist

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Top Medalists",
                                    style: FTextStyle.textSecBlackStylePrimary,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      /// 👉 navigate next page
                                    },
                                    child: Text(
                                      "View All",
                                      style: FTextStyle.privacyPolicyTxtStyle,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),
                              SizedBox(
                                height: listHeight,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  itemCount: medalists.length,
                                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    final m = medalists[index];

                                    final cardWidth = screenWidth * .48;

                                    /// ⭐ reduce image height slightly
                                    final imageHeight = cardWidth * .34;

                                    return Container(
                                      width: cardWidth,
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [Color(0xFF4A014F), Color(0xFF7A0B63)],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(.18),
                                            blurRadius: 18,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          /// 🔥 TOP ROW
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Container(
                                                  height: imageHeight,
                                                  width: imageHeight,
                                                  color: Colors.white,
                                                  child: (m["image"] != null && m["image"] != "")
                                                      ? Image.asset(m["image"], fit: BoxFit.cover)
                                                      : null,
                                                ),
                                              ),

                                              const SizedBox(width: 10),

                                              /// ⭐ Expanded prevents overflow
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    _medal("assets/images/gold.png", m["gold"]),
                                                    const SizedBox(height: 6),
                                                    _medal("assets/images/silver.png", m["silver"]),
                                                    const SizedBox(height: 6),
                                                    _medal("assets/images/bronze.png", m["bronze"]),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 8),

                                          /// NAME
                                          Text(
                                            m["name"],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: FTextStyle.medalSub.copyWith(
                                              fontSize: 11,
                                              color: AppColors.whiteColors,
                                            ),
                                          ),

                                          const SizedBox(height: 4),

                                          /// UNIVERSITY
                                          Text(
                                            m["university"],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: FTextStyle.medalSub,
                                          ),

                                          const Spacer(), /// ⭐ VERY IMPORTANT

                                          /// SPORT PILL
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              m["sport"],
                                              style: FTextStyle.navbarSelected.copyWith(
                                                fontSize: 10,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                              // SizedBox(
                              //   height: MediaQuery.of(context).size.width * .55,
                              //   child: ListView.separated(
                              //     scrollDirection: Axis.horizontal,
                              //     padding: const EdgeInsets.symmetric(horizontal: 8),
                              //     itemCount: medalists.length,
                              //     separatorBuilder: (_, __) => const SizedBox(width: 10),
                              //     itemBuilder: (context, index) {
                              //       final m = medalists[index];
                              //       final cardWidth = MediaQuery.of(context).size.width * .48;
                              //
                              //       return Container(
                              //         width: cardWidth,
                              //         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(20),
                              //           gradient: const LinearGradient(
                              //             begin: Alignment.topLeft,
                              //             end: Alignment.bottomRight,
                              //             colors: [Color(0xFF4A014F), Color(0xFF7A0B63)],
                              //           ),
                              //           boxShadow: [
                              //             BoxShadow(
                              //               color: Colors.black.withOpacity(.18),
                              //               blurRadius: 18,
                              //               offset: const Offset(0, 8),
                              //             ),
                              //           ],
                              //         ),
                              //
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Column(
                              //             mainAxisAlignment: MainAxisAlignment.start,
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //
                              //               /// 🔥 CLIPPED IMAGE (NOT CIRCLE)
                              //               Row(
                              //                 mainAxisAlignment: MainAxisAlignment.start,
                              //                 crossAxisAlignment: CrossAxisAlignment.start,
                              //                 children: [
                              //                   ClipRRect(
                              //                     borderRadius: BorderRadius.circular(12),
                              //                     child: Container(
                              //                       height: cardWidth * .38,
                              //                       width: cardWidth * .36,
                              //                       color: Colors.white,
                              //                       child: (m["image"] != null && m["image"] != "")
                              //                           ? Image.asset(m["image"], fit: BoxFit.cover)
                              //                           : null,
                              //                     ),
                              //                   ),
                              //                   SizedBox(width: 20,),
                              //                   Column(
                              //                     children: [
                              //                       _medal("assets/images/gold.png", m["gold"]),
                              //                       SizedBox(height: 8),
                              //                       _medal("assets/images/silver.png", m["silver"]),
                              //                       SizedBox(height: 8),
                              //                       _medal("assets/images/bronze.png", m["bronze"]),
                              //                     ],
                              //                   ),
                              //                 ],
                              //               ),
                              //
                              //               const SizedBox(height: 5),
                              //
                              //               /// Name
                              //               Text(
                              //                 m["name"],
                              //                 textAlign: TextAlign.start,
                              //                 maxLines: 1,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: FTextStyle.medalSub.copyWith(fontSize: 10,color: AppColors.whiteColors)
                              //               ),
                              //               const SizedBox(height: 5),
                              //
                              //               /// Name
                              //               Text(
                              //                 m["university"],
                              //                 textAlign: TextAlign.start,
                              //                 maxLines: 2,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: FTextStyle.medalSub
                              //               ),
                              //
                              //               const SizedBox(height: 5),
                              //
                              //               /// Sport pill
                              //               Container(
                              //                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              //                 decoration: BoxDecoration(
                              //                   color: Colors.white,
                              //                   borderRadius: BorderRadius.circular(20),
                              //                 ),
                              //                 child: Text(
                              //                   m["sport"],
                              //                   style: FTextStyle.navbarSelected.copyWith(fontSize: 10,color: AppColors.primaryColor)
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       );
                              //     },
                              //   ),
                              // ),
                            ],
                          ),






                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),


                            child:Column(
                              children: [

                              ],
                            ) ,)
                          ,
                          // Container(
                          //   height: 600,
                          //   color: Colors.transparent,
                          // ),
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
        Text(
          count.toString().padLeft(2, '0'),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 11,
            fontFamily: "Montserrat",
          ),
        )
      ],
    );
  }
  // void navigate(BuildContext context, int index) {
  //   switch (index) {
  //     case 0:
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (_) => AboutScreen()));
  //       break;
  //     case 1:
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (_) => AboutScreen()));
  //       break;
  //     case 2:
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (_) => AboutScreen()));
  //       break;
  //     case 3:
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (_) => AboutScreen()));
  //       break;
  //     case 4:
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (_) => AboutScreen()));
  //       break;
  //     case 5:
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (_) => AboutScreen()));
  //       break;
  //   }
  // }

}
