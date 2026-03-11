import 'package:flutter/material.dart';
import 'package:gms_application/core/constants/themes_colors.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';
import 'package:gms_application/core/utils/simple_translator.dart';

class AccredCentersScreen extends StatelessWidget {
  const AccredCentersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(
        title: "Accred Centers",
        showBack: true,
        showNotification: true,
        backgroundColor: AppColors.whiteColors,
        showBottomDivider: true,
      ),
      body: Center(
        child: TrText("Accred Centers (coming soon)"),
      ),
    );
  }
}
