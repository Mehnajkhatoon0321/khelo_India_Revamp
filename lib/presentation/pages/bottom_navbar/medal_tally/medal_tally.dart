import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';

class MedalTallyScreen extends StatefulWidget {
  const MedalTallyScreen({super.key});

  @override
  State<MedalTallyScreen> createState() => _MedalTallyScreenState();
}

class _MedalTallyScreenState extends State<MedalTallyScreen> {


  int _selectedCompetitionId = 1;

  final Map<String, dynamic> _medalTallyJson = {
    "competitions": [
      {"id": 1, "label": "Khelo India Water Sports Festival Games 2026"},
      {"id": 2, "label": "Khelo India Winter Sports Festival Games 2026"},
      {"id": 3, "label": "Khelo India University Games 2026"},
    ],
    "rows": [
      {
        "rank": 1,
        "state": "Maharashtra",
        "stateImage": "assets/images/profile_image.png",
        "gold": 58,
        "silver": 27,
        "bronze": 30,
        "total": 158,
      },
      {
        "rank": 2,
        "state": "Haryana",
        "stateImage": "assets/images/profile_image.png",
        "gold": 58,
        "silver": 27,
        "bronze": 30,
        "total": 158,
      },
      {
        "rank": 3,
        "state": "Rajasthan",
        "stateImage": "assets/images/profile_image.png",
        "gold": 58,
        "silver": 27,
        "bronze": 30,
        "total": 158,
      },
      {
        "rank": 4,
        "state": "Haryana",
        "stateImage": "assets/images/profile_image.png",
        "gold": 58,
        "silver": 27,
        "bronze": 30,
        "total": 158,
      },
      {
        "rank": 5,
        "state": "Rajasthan",
        "stateImage": "assets/images/profile_image.png",
        "gold": 58,
        "silver": 27,
        "bronze": 30,
        "total": 158,
      },
      {
        "rank": 6,
        "state": "Haryana",
        "stateImage": "assets/images/profile_image.png",
        "gold": 58,
        "silver": 27,
        "bronze": 30,
        "total": 158,
      },
      {
        "rank": 7,
        "state": "Rajasthan",
        "stateImage": "assets/images/profile_image.png",
        "gold": 58,
        "silver": 27,
        "bronze": 30,
        "total": 158,
      },
    ],
  };

  List<Map<String, dynamic>> get _competitions =>
      (_medalTallyJson["competitions"] as List).cast<Map<String, dynamic>>();

  List<Map<String, dynamic>> get _tallyRows =>
      (_medalTallyJson["rows"] as List).cast<Map<String, dynamic>>();

  @override
  Widget build(BuildContext context) {
    final totalGold =_tallyRows.fold<int>(0, (sum, row) => sum + (row["gold"] as int));
    final totalSilver = _tallyRows.fold<int>(0, (sum, row) => sum + (row["silver"] as int));
    final totalBronze = _tallyRows.fold<int>(0, (sum, row) => sum + (row["bronze"] as int));

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColors,
        body: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteOffColors,

                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/medal_left.png",
                          width: 24.w,
                          height: 24.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          "Medal at Stake",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FTextStyle.textSecBlackStylePrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: _openCompetitionSheet,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          _competitions
                              .firstWhere(
                                (e) => e["id"] == _selectedCompetitionId,
                          )["label"]
                              .toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FTextStyle.helloTxt,
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
                ),
                SizedBox(height: 10.h),
                Divider(height: 2,thickness: 2,color: AppColors.whiteOffColors,),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 12.w,
                  top: 10.w,
                  right: 12.w,
                  bottom: 18.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMedalSummaryCard(
                      totalGold: totalGold,
                      totalSilver: totalSilver,
                      totalBronze: totalBronze,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Medal Tally",
                      style: FTextStyle.textSecBlackStylePrimary,
                    ),
                    SizedBox(height: 12.h),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final layout = _createTallyLayout(constraints.maxWidth);
                        return Column(
                          children: [
                            _buildTableHeader(layout),
                            SizedBox(height: 10.h),
                            ListView.separated(
                              itemCount: _tallyRows.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, __) => SizedBox(height: 10.h),
                              itemBuilder: (_, index) {
                                final row = _tallyRows[index];
                                return _buildTallyRow(row, layout);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedalSummaryCard({
    required int totalGold,
    required int totalSilver,
    required int totalBronze,
  }) {
    return Container(
      width: double.infinity,
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        image: const DecorationImage(
          image: AssetImage("assets/images/medal_back.png"),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildMedalChip("Silver", totalSilver),

          _buildMedalChip("Gold", totalGold),
          _buildMedalChip("Bronze", totalBronze),
        ],
      ),
    );
  }

  Widget _buildMedalChip(String label, int count) {
    final bool isGold = label == "Gold";

    /// ⭐ Gold bigger
    final double medalSize = isGold ? 111.w : 47.w;

    String medalImage =
    label == "Gold"
        ? "assets/images/medal_card_gold.png"
        : label == "Silver"
        ? "assets/images/medal_card_silver.png"
        : "assets/images/medal_card_bronze.png";

    return GestureDetector(
      onTap: () {

      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// ⭐ fixed box removes spacing issue
        SizedBox(
        width: medalSize,
        height: isGold ? medalSize - 24.h : medalSize,   // ⭐ height reduce
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: isGold ? Offset(0, -0.h) : Offset.zero,
              child: Image.asset(
                medalImage,
                width: medalSize,
                height: medalSize,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: isGold ? 14.sp : 10.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xff6B3A00),
              ),
            ),
         ] )
         ),

          /// ⭐ very small gap
          SizedBox(height: 2.h),

          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildTableHeader(_TallyLayout layout) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: layout.rowPadding, vertical: 10.h),
      decoration: BoxDecoration(
        color:AppColors.whiteOffColors,
        borderRadius: BorderRadius.circular(12.r),
        // boxShadow: const [
        //   // BoxShadow(
        //   //   color: Color(0x14000000),
        //   //   blurRadius: 10,
        //   //   offset: Offset(0, 4),
        //   // ),
        // ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: layout.rankWidth,
            child: Text(
              "Rank",
              style: FTextStyle.chipText,
            ),
          ),
          SizedBox(width: layout.rankToIconGap),
          SizedBox(width: layout.stateIconWidth),
          SizedBox(width: layout.iconToStateGap),
          Expanded(
            child: Text(
              "State",
              style: FTextStyle.chipText,
            ),
          ),
          SizedBox(width: layout.stateToMedalGap),
          _buildMedalHeaderCircle(
            imagePath: "assets/images/medal_total_gold.png",
            backgroundColor: const Color(0xFFFFF5D6),
            size: layout.medalIconSize,
          ),
          SizedBox(width: layout.medalGap),
          _buildMedalHeaderCircle(
            imagePath: "assets/images/medal_total_silver.png",
            backgroundColor: const Color(0xFFEFF2FF),
            size: layout.medalIconSize,
          ),
          SizedBox(width: layout.medalGap),
          _buildMedalHeaderCircle(
            imagePath: "assets/images/medal_total_bronze.png",
            backgroundColor: const Color(0xFFFFE3D3),
            size: layout.medalIconSize,
          ),
          SizedBox(width: layout.medalGap),
          SizedBox(
            width: layout.totalWidth,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total",
                style: FTextStyle.chipText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedalHeaderCircle({
    required String imagePath,
    required Color backgroundColor,
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: Image.asset(
        imagePath,
        height: size,
        width: size,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTallyRow(Map<String, dynamic> row, _TallyLayout layout) {
    final int rank = row["rank"] as int;
    final Gradient? cardGradient;

    if (rank == 1) {
      cardGradient = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFFEECAC), Color(0xFFFFFFFF)],
      );
    } else if (rank == 2) {
      cardGradient = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFE4E4E4), Color(0xFFFFFFFF)],
      );
    } else if (rank == 3) {
      cardGradient = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFF7D3B8), Color(0xFFFFFFFF)],
      );
    } else {
      cardGradient = null;
    }

    final String? rankImagePath = _getRankImagePath(rank);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: layout.rowPadding, vertical: 12.h),
      decoration: BoxDecoration(
        color: cardGradient == null ? Colors.white : null,
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.whiteOffColors,width: 2.0),

      ),
      child: Row(
        children: [
          SizedBox(
            width: layout.rankWidth,
            child: Align(
              alignment: Alignment.centerLeft,
              child: rankImagePath != null
                  ? Image.asset(
                      rankImagePath,
                      width: layout.rankImageWidth,
                      height: layout.rankImageHeight,
                      fit: BoxFit.contain,
                    )
                  : Text(
                      rank.toString(),
                      style: FTextStyle.cardTileText.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
          SizedBox(width: layout.rankToIconGap),
          Image.asset(
            (row["stateImage"] ?? "assets/images/profile_image.png").toString(),
            width: layout.stateIconWidth,
            height: layout.stateIconWidth,
            fit: BoxFit.cover,
          ),
          SizedBox(width: layout.iconToStateGap),
          Expanded(
            child: Text(
              row["state"].toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: FTextStyle.cardTileText.copyWith(
                fontFamily: "Montserrat",
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                height: 1.13,
                letterSpacing: 0,
              ),
            ),
          ),
          SizedBox(width: layout.stateToMedalGap),
          _buildCountText(row["gold"] as int, width: layout.countWidth),
          SizedBox(width: layout.medalGap),
          _buildCountText(row["silver"] as int, width: layout.countWidth),
          SizedBox(width: layout.medalGap),
          _buildCountText(row["bronze"] as int, width: layout.countWidth),
          SizedBox(width: layout.medalGap),
          SizedBox(
            width: layout.totalWidth,
            child: Align(
              alignment: Alignment.centerRight,
              child: _buildCountText(
                row["total"] as int,
                isBold: true,
                width: layout.totalWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountText(
    int value, {
    bool isBold = false,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: Text(
        value.toString(),
        textAlign: TextAlign.center,
        style: FTextStyle.datePicker.copyWith(
          fontFamily: "Montserrat",
          fontSize: 13.sp,
          fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
          height: 1.13,
          letterSpacing: 0,
        ),
      ),
    );
  }

  _TallyLayout _createTallyLayout(double maxWidth) {
    final double rankWidth = (maxWidth * 0.08).clamp(24.0, 36.w);
    final double rankToIconGap = (maxWidth * 0.012).clamp(2.0, 6.w);
    final double stateIconWidth = (maxWidth * 0.07).clamp(18.0, 26.w);
    final double iconToStateGap = (maxWidth * 0.012).clamp(4.0, 8.w);
    final double stateToMedalGap = (maxWidth * 0.012).clamp(4.0, 6.w);
    final double medalGap = (maxWidth * 0.016).clamp(5.0, 10.w);
    final double countWidth = (maxWidth * 0.07).clamp(18.0, 26.w);
    final double totalWidth = (maxWidth * 0.075).clamp(20.0, 28.w);
    final double rowPadding = (maxWidth * 0.025).clamp(8.0, 12.w);
    final double medalIconSize = (maxWidth * 0.07).clamp(20.0, 26.w);
    final double rankImageWidth = (maxWidth * 0.055).clamp(16.0, 20.w);
    final double rankImageHeight = (maxWidth * 0.065).clamp(18.0, 23.w);

    return _TallyLayout(
      rankWidth: rankWidth,
      rankToIconGap: rankToIconGap,
      stateIconWidth: stateIconWidth,
      iconToStateGap: iconToStateGap,
      stateToMedalGap: stateToMedalGap,
      medalGap: medalGap,
      countWidth: countWidth,
      totalWidth: totalWidth,
      rowPadding: rowPadding,
      medalIconSize: medalIconSize,
      rankImageWidth: rankImageWidth,
      rankImageHeight: rankImageHeight,
    );
  }

  String? _getRankImagePath(int rank) {
    if (rank == 1) return "assets/images/medal_rank_first.png";
    if (rank == 2) return "assets/images/medal_rank_second.png";
    if (rank == 3) return "assets/images/medal_rank_third.png";
    return null;
  }

  void _openCompetitionSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: .42,
          minChildSize: .32,
          maxChildSize: .75,
          builder: (_, controller) {
            return Container(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 26),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(26)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.08),
                    blurRadius: 20,
                    offset: const Offset(0, -6),
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 4.5,
                    width: 46,
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Text(
                    "Select Competition",
                    style: FTextStyle.helloTxt.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      controller: controller,
                      itemCount: _competitions.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, index) {
                        final item = _competitions[index];
                        final bool isSelected =
                            item["id"] == _selectedCompetitionId;

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              setState(() {
                                _selectedCompetitionId = item["id"] as int;
                              });
                              Navigator.pop(context);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 13,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryColor.withOpacity(.08)
                                    : AppColors.whiteOffColors,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item["label"].toString(),
                                      style: FTextStyle.helloTxt.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 220),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? AppColors.primaryColor
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : Colors.grey.shade300,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: isSelected
                                        ? const Icon(
                                            Icons.check,
                                            size: 12,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _TallyLayout {
  const _TallyLayout({
    required this.rankWidth,
    required this.rankToIconGap,
    required this.stateIconWidth,
    required this.iconToStateGap,
    required this.stateToMedalGap,
    required this.medalGap,
    required this.countWidth,
    required this.totalWidth,
    required this.rowPadding,
    required this.medalIconSize,
    required this.rankImageWidth,
    required this.rankImageHeight,
  });

  final double rankWidth;
  final double rankToIconGap;
  final double stateIconWidth;
  final double iconToStateGap;
  final double stateToMedalGap;
  final double medalGap;
  final double countWidth;
  final double totalWidth;
  final double rowPadding;
  final double medalIconSize;
  final double rankImageWidth;
  final double rankImageHeight;
}
