// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onTap;

  const RoundButton({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            color: AppColors.buttonkColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  color: AppColors.whiteColor,
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.whiteColor,
                  ),
                ),
        ),
      ),
    );
  }
}
