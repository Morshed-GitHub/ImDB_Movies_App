import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  final String title;
  const Headline({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
