import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool showNotification;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.showNotification = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),

      /// ✅ BACK BUTTON
      leading: showBack
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      )
          : null,

      /// ✅ TITLE
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),

      /// ✅ ACTIONS
      actions: actions ??
          [
            if (showNotification)
              Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: CircleAvatar(
                      backgroundColor: Color(0xffF2F2F2),
                      child: Icon(Icons.notifications_none, color: Colors.black),
                    ),
                  ),
                  Positioned(
                    right: 14,
                    top: 14,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              )
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
