
import 'package:flutter/material.dart';
import 'package:planmate/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double? iconSize;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? AppColors.backgroundOnboarding,
      child: Icon(
        Icons.sync_alt,
        color: Colors.white,
        size: iconSize ?? 32,
      ),
    );
  }
}
