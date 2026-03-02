import 'package:flutter/material.dart';
import 'package:gms_application/core/widgets/app_bar_view.dart';
class Venue extends StatefulWidget {
  const Venue({super.key});

  @override
  State<Venue> createState() => _VenueState();
}

class _VenueState extends State<Venue> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(
        title: "Venues",
        showBack: true,
        showNotification: true,
      ),
      body: Center(
        child: Text("Venues (coming soon)"),
      ),
    );
  }
}
