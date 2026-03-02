import 'package:flutter/material.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';

class AccredCentersScreen extends StatelessWidget {
  const AccredCentersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(
        title: "Accred Centers",
        showBack: true,
        showNotification: true,
      ),
      body: Center(
        child: Text("Accred Centers (coming soon)"),
      ),
    );
  }
}

