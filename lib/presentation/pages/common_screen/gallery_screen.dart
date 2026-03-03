import 'package:flutter/material.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(
        title: "Gallery",
        showBack: true,
        showNotification: true,
        backgroundColor: Colors.white,
        showBottomDivider: false,
      ),
      body: Center(
        child: Text("Gallery (coming soon)"),
      ),
    );
  }
}

