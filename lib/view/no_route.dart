import 'package:flutter/material.dart';

class FaultRouteView extends StatelessWidget {
  const FaultRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text(
          'No Route Defined',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
