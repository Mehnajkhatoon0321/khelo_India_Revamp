import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';
import 'package:gms_application/core/widgets/select_competition_screen.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/data/competition_list_data.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/medal_tally/medal_sports_list.dart';

class MedalTallyScreen extends StatefulWidget {
  const MedalTallyScreen({super.key});

  @override
  State<MedalTallyScreen> createState() => _MedalTallyScreenState();
}

class _MedalTallyScreenState extends State<MedalTallyScreen> {
  int _selectedCompetitionId = 1;

  final Map<String, dynamic> _medalTallyJson = {
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

  List<Map<String, dynamic>> get _competitions => kCompetitionList;

  List<Map<String, dynamic>> get _tallyRows =>
      (_medalTallyJson["rows"] as List).cast<Map<String, dynamic>>();

  @override
  Widget build(BuildContext context) {
    final totalGold =
        _tallyRows.fold<int>(0, (sum, row) => sum + (row["gold"] as int));
    final totalSilver =
        _tallyRows.fold<int>(0, (sum, row) => sum + (row["silver"] as int));
    final totalBronze =
        _tallyRows.fold<int>(0, (sum, row) => sum + (row["bronze"] as int));

    return Scaffold(
      backgroundColor: AppColors.whiteColors,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 6),
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
                        child: TrText(
                          "Medal at Stake",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FTextStyle.textSecBlackStylePrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                GestureDetector(
                  onTap: _openCompetitionSheet,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: TrText(
                          getCompetitionLabelById(_selectedCompetitionId),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FTextStyle.helloTxt,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: AppColors.appBarTitle,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: AppColors.whiteOffColors,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 12.w,
                  top: 6.w,
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
                    TrText(
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
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 10.h),
                              itemBuilder: (_, index) {
                                final row = _tallyRows[index];
                                return _buildTallyRow(row, layout, index);
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

    String medalImage = label == "Gold"
        ? "assets/images/medal_card_gold.png"
        : label == "Silver"
            ? "assets/images/medal_card_silver.png"
            : "assets/images/medal_card_bronze.png";

    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// ⭐ fixed box removes spacing issue
          SizedBox(
              width: medalSize,
              height: isGold ? medalSize - 24.h : medalSize, // ⭐ height reduce
              child: Stack(alignment: Alignment.center, children: [
                Transform.translate(
                  offset: isGold ? Offset(0, -0.h) : Offset.zero,
                  child: Image.asset(
                    medalImage,
                    width: medalSize,
                    height: medalSize,
                    fit: BoxFit.contain,
                  ),
                ),
                TrText(
                  count.toString(),
                  style: FTextStyle.cardTileText.copyWith(
                    fontSize: isGold ? 14.sp : 10.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.medalCountText,
                  ),
                ),
              ])),

          /// ⭐ very small gap
          SizedBox(height: 2.h),

          TrText(
            label,
            style: FTextStyle.medalSub.copyWith(
              fontSize: 11.sp,
              color: AppColors.whiteColors,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(_TallyLayout layout) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: layout.rowPadding, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.whiteOffColors,
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
            child: TrText(
              "Rank",
              style: FTextStyle.chipText,
            ),
          ),
          SizedBox(width: layout.rankToIconGap),
          SizedBox(width: layout.stateIconWidth),
          SizedBox(width: layout.iconToStateGap),
          Expanded(
            child: TrText(
              "State",
              style: FTextStyle.chipText,
            ),
          ),
          SizedBox(width: layout.stateToMedalGap),
          _buildMedalHeaderCircle(
            imagePath: "assets/images/medal_total_gold.png",
            backgroundColor: AppColors.medalHeaderGoldBg,
            size: layout.medalIconSize,
          ),
          SizedBox(width: layout.medalGap),
          _buildMedalHeaderCircle(
            imagePath: "assets/images/medal_total_silver.png",
            backgroundColor: AppColors.medalHeaderSilverBg,
            size: layout.medalIconSize,
          ),
          SizedBox(width: layout.medalGap),
          _buildMedalHeaderCircle(
            imagePath: "assets/images/medal_total_bronze.png",
            backgroundColor: AppColors.medalHeaderBronzeBg,
            size: layout.medalIconSize,
          ),
          SizedBox(width: layout.medalGap),
          SizedBox(
            width: layout.totalWidth,
            child: Align(
              alignment: Alignment.centerRight,
              child: TrText(
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

  Widget _buildTallyRow(
      Map<String, dynamic> row, _TallyLayout layout, int index) {
    final int rank = row["rank"] as int;
    final Gradient? cardGradient;

    if (rank == 1) {
      cardGradient = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [AppColors.medalFirstGradientStart, AppColors.whiteColors],
      );
    } else if (rank == 2) {
      cardGradient = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [AppColors.medalSecondGradientStart, AppColors.whiteColors],
      );
    } else if (rank == 3) {
      cardGradient = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [AppColors.medalThirdGradientStart, AppColors.whiteColors],
      );
    } else {
      cardGradient = null;
    }

    final String? rankImagePath = _getRankImagePath(rank);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 240 + (index * 55)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - value)),
            child: child,
          ),
        );
      },
      child: InkWell(
        borderRadius: BorderRadius.circular(18.r),
        onTap: () => _openSportsList(row),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: layout.rowPadding,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            color: cardGradient == null ? AppColors.whiteColors : null,
            gradient: cardGradient,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.whiteOffColors, width: 2.0),
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
                      : TrText(
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
                (row["stateImage"] ?? "assets/images/profile_image.png")
                    .toString(),
                width: layout.stateIconWidth,
                height: layout.stateIconWidth,
                fit: BoxFit.cover,
              ),
              SizedBox(width: layout.iconToStateGap),
              Expanded(
                child: TrText(
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
        ),
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
      child: TrText(
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

  Future<void> _openCompetitionSheet() async {
    final int? selectedId = await openSelectCompetitionBottomSheet(
      context: context,
      selectedCompetitionId: _selectedCompetitionId,
      competitions: _competitions,
    );

    if (!mounted || selectedId == null) return;
    setState(() {
      _selectedCompetitionId = selectedId;
    });
  }

  void _openSportsList(Map<String, dynamic> row) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MedalSportsList(
          teamTitle: row['state']?.toString() ?? 'Sports',
        ),
      ),
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
