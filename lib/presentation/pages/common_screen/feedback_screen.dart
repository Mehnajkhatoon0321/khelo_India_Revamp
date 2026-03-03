import 'package:flutter/material.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(
        title: "Feedback",
        showBack: true,
        showNotification: true,
        backgroundColor: Colors.white,
        showBottomDivider: false,
      ),
      body: Center(
        child: Text("Feedback (coming soon)"),
      ),
    );
  }
}

