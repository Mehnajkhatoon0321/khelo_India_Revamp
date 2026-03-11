import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gms_application/core/constants/fonts_text_style.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/utils/simple_translator.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool showNotification;
  final List<Widget>? actions;
  final double? toolbarHeight;
  final bool showBottomDivider;
  final Color backgroundColor;
  final double dividerTopSpacing;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.showNotification = false,
    this.actions,
    this.toolbarHeight,
    this.showBottomDivider = true,
    this.backgroundColor = AppColors.screenBackground,
    this.dividerTopSpacing = 10,
  });

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = toolbarHeight ?? 56;

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: appBarHeight,
      centerTitle: false,
      leadingWidth: showBack ? 62 : null,
      titleSpacing: showBack ? 14 : 16,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      leading: showBack
          ? Padding(
              padding: const EdgeInsets.only(left: 15),
              child: _CircleIconButton(
                icon: Icons.arrow_back,
                onTap: () => Navigator.pop(context),
              ),
            )
          : null,
      title: TrText(
        title,
        style: FTextStyle.appBarTitleStyle.copyWith(fontSize: 16.sp),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: actions ??
          [
            if (showNotification)
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: _NotificationButton(),
              ),
          ],
      bottom: showBottomDivider
          ? PreferredSize(
              preferredSize: Size.fromHeight(dividerTopSpacing + 0.5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: dividerTopSpacing),
                  const Divider(
                    height: 0,
                    thickness: 0.5,
                    color: AppColors.appBarDivider,
                  ),
                ],
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        (toolbarHeight ?? 56) +
            (showBottomDivider ? (dividerTopSpacing + 0.5) : 0),
      );
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
      color: AppColors.appBarIconBg,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 42,
          width: 42,
          child: Icon(
            Icons.arrow_back,
            color: AppColors.appBarTitle,
            size: 18,
          ),
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
          color: AppColors.appBarIconBg,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {},
            child: const SizedBox(
              height: 42,
              width: 42,
              child: Icon(
                Icons.notifications_outlined,
                color: AppColors.appBarTitle,
                size: 24,
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Container(
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
                color: AppColors.danger, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}
