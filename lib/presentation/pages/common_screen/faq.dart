import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/widgets/no_data_available.dart';
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
      backgroundColor: AppColors.whiteOffColors,
      appBar: _TopAppBar(
        title: "FAQ",
        onBack: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Column(
          children: [
            _SearchField(
              controller: _search,
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 420.w),
                child: SizedBox(
                  height: 35.h,
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
                            final int id = (item["id"] is num) ? (item["id"] as num).toInt() : index;
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
    );
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }
}

class _TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBack;

  const _TopAppBar({
    required this.title,
    required this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteOffColors,
      elevation: 0,
      leadingWidth: 56,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: _CircleIconButton(
          icon: Icons.arrow_back,
          onTap: onBack,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: _NotificationButton(),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF2F2F2),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 40,
          width: 40,
          child: Icon(icon, color: AppColors.textPrimary, size: 20),
        ),
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          color: const Color(0xFFF2F2F2),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {},
            child: const SizedBox(
              height: 40,
              width: 40,
              child: Icon(Icons.notifications_none, color: AppColors.textPrimary, size: 20),
            ),
          ),
        ),
        Positioned(
          right: 11,
          top: 10,
          child: Container(
            height: 7,
            width: 7,
            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          ),
        ),
      ],
    );
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
      height: 46,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(26.r),
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
        borderRadius: BorderRadius.circular(17.5.r),
        onTap: onTap,
        child: Container(
          height: 35.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(17.5.r),
            border: Border.all(color: border),
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: fg,
                height: 1.0,
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
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
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
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        height: 1.25,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Icon(
                    expanded ? Icons.remove : Icons.add,
                    size: 18,
                    color: AppColors.textPrimary,
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
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 1.5,
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
