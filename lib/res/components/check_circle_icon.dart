import 'package:flutter/material.dart';

import '../colors.dart';

class CheckCircleIcon extends StatelessWidget {
  final double? size;
  const CheckCircleIcon({
    super.key,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check_circle_outline_outlined,
      color: AppColors.whiteColor,
      size: size,
    );
  }
}
