import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';
import 'package:gms_application/core/widgets/no_data_available.dart';
import 'package:gms_application/core/widgets/responsive_layout.dart';
import 'package:gms_application/core/widgets/shimmer_screen.dart';

class FaqScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  final bool isLoading;
  final bool useDummyItems;
  final List<String> defaultCategories;

  const FaqScreen({
    super.key,
    this.data,
    this.isLoading = false,
    this.useDummyItems = true,
    this.defaultCategories = const ["General", "Accommodation", "Transport", "Catering"],
  });

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final TextEditingController _search = TextEditingController();

  int _selectedCategoryIndex = 0;
  final Set<int> _expandedIds = <int>{};

  static const Map<String, dynamic> _mockData = {
    "itemsByCategory": {
      "General": [
        {
          "id": 0,
          "question": "What are the eligibility criteria to\nparticipate in games?",
          "answer":
              "The athlete must be a part of the merit list of NSF/\nSGFI/CBSE for being eligible to participate in Khelo\nIndia Youth Games Bihar 2025",
        },
        {
          "id": 1,
          "question": "How to register in Khelo India Portal?",
          "answer": "Registration can be done through the official Khelo India portal.",
        },
      ],
      "Accommodation": [
        {
          "id": 10,
          "question": "Where will athletes be accommodated?",
          "answer":
              "Accommodation details are shared by the organizing committee. Assigned hotels/hostels will be visible in your allotment section once confirmed.",
        },
        {
          "id": 11,
          "question": "What documents are required at check-in?",
          "answer": "Carry your accreditation/ID proof and the allotment confirmation.",
        },
      ],
      "Transport": [

      ],
      "Catering": [
        {
          "id": 30,
          "question": "What meals will be provided?",
          "answer":
              "Breakfast, lunch, and dinner are provided as per the event catering plan. Timings and locations will be communicated at the venue/accommodation.",
        },
        {
          "id": 31,
          "question": "Are special dietary requirements supported?",
          "answer": "Yes, where possible. Inform the organizers in advance.",
        },
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        widget.data ?? (widget.useDummyItems ? _mockData : const {});

    final List itemsRaw = (data["items"] is List) ? (data["items"] as List) : const [];
    final dynamic itemsByCategoryRaw = data["itemsByCategory"];

    final List<String> categories = widget.defaultCategories;
    final int safeSelectedIndex = _selectedCategoryIndex.clamp(0, categories.length - 1);
    final String selectedLabel = categories[safeSelectedIndex];
    final query = _search.text.trim().toLowerCase();

    List<Map> categoryItems = [];
    if (itemsByCategoryRaw is Map) {

      dynamic rawList = itemsByCategoryRaw[selectedLabel];
      if (rawList == null) {
        final lower = selectedLabel.toLowerCase();
        for (final key in itemsByCategoryRaw.keys) {
          if (key.toString().toLowerCase() == lower) {
            rawList = itemsByCategoryRaw[key];
            break;
          }
        }
      }
      if (rawList is List) {
        categoryItems = rawList.whereType<Map>().toList();
      }
    } else {
      categoryItems = itemsRaw.whereType<Map>().where((raw) {
        final category = (raw["category"] ?? raw["categoryName"] ?? raw["type"] ?? "").toString();
        return category == selectedLabel;
      }).toList();
    }

    final faqs = categoryItems.where((raw) {
      final question = (raw["question"] ?? "").toString();
      final answer = (raw["answer"] ?? "").toString();
      if (query.isEmpty) return true;
      return question.toLowerCase().contains(query) || answer.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.whiteColors,
      appBar: const CommonAppBar(
        title: "FAQ",
        toolbarHeight: 42,
        backgroundColor: AppColors.whiteColors,
        showBottomDivider: false,
      ),
      body: Column(
        children: [
          const Divider(height: 0, thickness: 0.5, color: Color(0xFFE0E0E0)),
          Expanded(
            child: ResponsiveContent(
              padding: EdgeInsets.fromLTRB(
                ResponsiveLayout.adaptiveHorizontalPadding(context),
                14.h,
                ResponsiveLayout.adaptiveHorizontalPadding(context),
                12.h,
              ),
              child: Column(
                children: [
                  _SearchField(
                    controller: _search,
                    onChanged: (_) => setState(() {}),
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 420.w),
                      child: SizedBox(
                        height: 40.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (_, __) => SizedBox(width: 10.w),
                          itemBuilder: (context, index) {
                            final isSelected = index == safeSelectedIndex;
                            return _CategoryChip(
                              label: categories[index],
                              selected: isSelected,
                              onTap: () => setState(() => _selectedCategoryIndex = index),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Expanded(
                    child: widget.isLoading
                        ? ListView.separated(
                            itemCount: 6,
                            separatorBuilder: (_, __) => SizedBox(height: 12.h),
                            itemBuilder: (_, __) => ShimmerCard.faq(),
                          )
                        : faqs.isEmpty
                            ? const NoDataAvailable(
                                title: "No data found",
                                subtitle: "FAQs will appear here",
                              )
                            : ListView.separated(
                                itemCount: faqs.length,
                                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                                itemBuilder: (context, index) {
                                  final Map item = faqs[index];
                                  final int id =
                                      (item["id"] is num) ? (item["id"] as num).toInt() : index;
                                  final expanded = _expandedIds.contains(id);
                                  return _FaqCard(
                                    item: item,
                                    expanded: expanded,
                                    onToggle: () {
                                      setState(() {
                                        if (expanded) {
                                          _expandedIds.remove(id);
                                        } else {
                                          _expandedIds.add(id);
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchField({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(27.r),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.textSecondary),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: const InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.primaryColor : Colors.white;
    final fg = selected ? Colors.white : AppColors.textPrimary;
    final border = selected ? AppColors.primaryColor : const Color(0xFFD9D9D9);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(27.5.r),
        onTap: onTap,
        child: Container(
          height: 20.h,
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(28.r),
            border: Border.all(color: border),
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: fg,
                height: 1.13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FaqCard extends StatelessWidget {
  final Map item;
  final bool expanded;
  final VoidCallback onToggle;

  const _FaqCard({
    required this.item,
    required this.expanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final String question = (item["question"] ?? "").toString();
    final String answer = (item["answer"] ?? "").toString();

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.r),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(18.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: const Color(0xFFE9E9E9)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                        question,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                        height: 1.54,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    height: 32,
                    width: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      expanded ? Icons.remove : Icons.add,
                      size: 18,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              if (expanded) ...[
                SizedBox(height: 10.h),
                Text(
                  answer,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.answerSecondary,
                    height: 1.64,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
