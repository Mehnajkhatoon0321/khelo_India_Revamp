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

  final List<Map<String, dynamic>> _competitions = [
    {"id": 1, "label": "Khelo India Water Sports Festival Games 2026"},
    {"id": 2, "label": "Khelo India Winter Sports Festival Games 2026"},
    {"id": 3, "label": "Khelo India University Games 2026"},
  ];

  /// Dummy tally data for UI
  final List<Map<String, dynamic>> _tallyRows = [
    {
      "rank": 1,
      "state": "Maharashtra",
      "gold": 58,
      "silver": 27,
      "bronze": 30,
      "total": 158,
    },
    {
      "rank": 2,
      "state": "Haryana",
      "gold": 58,
      "silver": 27,
      "bronze": 30,
      "total": 158,
    },
    {
      "rank": 3,
      "state": "Rajasthan",
      "gold": 58,
      "silver": 27,
      "bronze": 30,
      "total": 158,
    },
    {
      "rank": 4,
      "state": "Haryana",
      "gold": 58,
      "silver": 27,
      "bronze": 30,
      "total": 158,
    },
    {
      "rank": 5,
      "state": "Rajasthan",
      "gold": 58,
      "silver": 27,
      "bronze": 30,
      "total": 158,
    },
    {
      "rank": 6,
      "state": "Haryana",
      "gold": 58,
      "silver": 27,
      "bronze": 30,
      "total": 158,
    },
    {
      "rank": 7,
      "state": "Rajasthan",
      "gold": 58,
      "silver": 27,
      "bronze": 30,
      "total": 158,
    },
  ];

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
                    _buildTableHeader(),
                    SizedBox(height: 10.h),
                    ListView.separated(
                      itemCount: _tallyRows.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (_, index) {
                        final row = _tallyRows[index];
                        return _buildTallyRow(row);
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
  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
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
            width: 40.w,
            child: Text(
              "Rank",
              style: FTextStyle.chipText,
            ),
          ),
          SizedBox(
            width: 100.w,
            child: Text(
              "State",
              style: FTextStyle.chipText,
            ),
          ),
          const Spacer(),
          _buildMedalHeaderCircle(
            imagePath: "assets/images/medal_total_gold.png",
            backgroundColor: const Color(0xFFFFF5D6),
          ),
          SizedBox(width: 16.w),
          _buildMedalHeaderCircle(
            imagePath: "assets/images/medal_total_silver.png",
            backgroundColor: const Color(0xFFEFF2FF),
          ),
          SizedBox(width: 16.w),
          _buildMedalHeaderCircle(
            imagePath: "assets/images/medal_total_bronze.png",
            backgroundColor: const Color(0xFFFFE3D3),
          ),
          SizedBox(width: 16.w),
          SizedBox(
            width: 40.w,
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
  }) {
    return Container(
      width: 26.w,
      height: 26.w,
      // decoration: BoxDecoration(
      //   shape: BoxShape.circle,
      //   color: backgroundColor,
      // ),
      alignment: Alignment.center,
      child: Image.asset(
        imagePath,
        height: 26,
        width: 26,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTallyRow(Map<String, dynamic> row) {
    final int rank = row["rank"] as int;
    final Color medalColor;

    if (rank == 1) {
      medalColor = const Color(0xFFFFD465);
    } else if (rank == 2) {
      medalColor = const Color(0xFFE0E7FF);
    } else if (rank == 3) {
      medalColor = const Color(0xFFF0C0A0);
    } else {
      medalColor = const Color(0xFFEDEDED);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.whiteOffColors,width: 2.0),

      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: medalColor.withOpacity(0.2),
            ),
            alignment: Alignment.center,
            child: Text(
              rank.toString(),
              style: FTextStyle.cardTileText.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              row["state"].toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: FTextStyle.cardTileText,
            ),
          ),
          SizedBox(width: 10.w),
          _buildCountText(row["gold"] as int),
          SizedBox(width: 16.w),
          _buildCountText(row["silver"] as int),
          SizedBox(width: 16.w),
          _buildCountText(row["bronze"] as int),
          SizedBox(width: 16.w),
          SizedBox(
            width: 30.w,
            child: Align(
              alignment: Alignment.centerRight,
              child: _buildCountText(row["total"] as int, isBold: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountText(int value, {bool isBold = false}) {
    return SizedBox(
      width: 29.w,
      child: Text(
        value.toString(),
        textAlign: TextAlign.center,
        style: FTextStyle.datePicker.copyWith(
          fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
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
