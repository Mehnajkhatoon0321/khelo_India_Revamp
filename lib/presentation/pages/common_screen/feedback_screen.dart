import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';
import 'package:gms_application/core/utils/simple_translator.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(
        title: "Feedback",
        showBack: true,
        showNotification: true,
        backgroundColor: AppColors.whiteColors,
        showBottomDivider: true,
      ),
      body: Center(
        child: TrText("Feedback (coming soon)"),
      ),
    );
  }
}
