import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gms_application/core/constants/themes_colors.dart';

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
    this.backgroundColor = const Color(0xFFF8F8F8),
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

      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF2A2F46),
          fontFamily: "Montserrat",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.13,
          letterSpacing: 0,
        ),
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
                    color: Color(0xFFE0E0E0),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(
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
      color: const Color(0xFFF3F3F3),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 42,
          width: 42,
          child: Icon(
            Icons.arrow_back,
            color: const Color(0xFF2A2F46),
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
          color: const Color(0xFFF3F3F3),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {},
            child: const SizedBox(
              height: 42,
              width: 42,
              child: Icon(
                Icons.notifications_outlined,
                color: Color(0xFF2A2F46),
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
            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}
