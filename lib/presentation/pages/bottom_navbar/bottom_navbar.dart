import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/home_page.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/medal_tally/medal_tally.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/schedule.dart';
import 'package:gms_application/presentation/pages/bottom_navbar/venue.dart';

class BottomNavItem {
  final String label;
  final String selectedImage;
  final String image;
  final Widget page;

  const BottomNavItem({
    required this.label,
    required this.selectedImage,
    required this.image,
    required this.page,
  });
}

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedIndex = 0;

  late final List<BottomNavItem> navItems;

  @override
  void initState() {
    super.initState();

    navItems = const [
      BottomNavItem(
        label: "Home",
        image: "assets/images/home.png",
        selectedImage: "assets/images/home.png",
        page: HomePage(),
      ),
      BottomNavItem(
        label: "Schedule",
        image: "assets/images/schedule.png",
        selectedImage: "assets/images/scheduleFill.png",
        page: Schedule(),
      ),
      BottomNavItem(
        label: "Medals",
        image: "assets/images/venue.png",
        selectedImage: "assets/images/venue.png",
        page: MedalTallyScreen(),
      ), BottomNavItem(
        label: "Log In",
        image: "assets/images/login.png",
        selectedImage: "assets/images/login.png",
        page: HomePage(),
      ),
    ];
  }

  void onItemTap(int index) {
    if (selectedIndex == index) return;

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final navBarHeight = (screenHeight * 0.085).clamp(64.0, 84.0);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: navItems.map((item) => item.page).toList(),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: navBarHeight,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: List.generate(
              navItems.length,
                  (index) => Expanded(
                child: _buildNavItem(context, index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    final item = navItems[index];
    final bool isSelected = selectedIndex == index;

    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = (screenWidth * (isSelected ? 0.052 : 0.043)).clamp(18.0, 24.0);
    final indicatorWidth = (screenWidth * 0.15).clamp(44.0, 84.0);
    final topGap = (screenWidth * 0.03).clamp(8.0, 14.0);
    final labelGap = (screenWidth * 0.022).clamp(6.0, 10.0);

    return InkWell(
      onTap: () => onItemTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 🔹 Dynamic Indicator
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 3,
            width: indicatorWidth,
            color: isSelected
                ? AppColors.primaryColor
                : Colors.transparent,
          ),

          SizedBox(height: topGap),

          /// 🔹 Responsive Image
          SizedBox(
            height: iconSize,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                isSelected
                    ? AppColors.primaryColor
                    : Colors.black,
                BlendMode.srcIn,
              ),
              child: isSelected
                  ?
              Image.asset(
                 item.selectedImage,

                fit: BoxFit.contain,
              ): Image.asset(
                item.image,

                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(height: labelGap),

          /// 🔹 Responsive Text
          Flexible(
            child: Text(
              item.label,
              overflow: TextOverflow.ellipsis,
              style: isSelected
                  ? FTextStyle.navbarSelected
                  : FTextStyle.navbarDefault,
            ),
          ),
        ],
      ),
    );
  }
}
