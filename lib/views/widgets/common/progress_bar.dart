import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Rounded progress bar with an optional colour override.
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.value,
    this.color = AppColors.accent,
    this.trackColor = AppColors.surfaceMuted,
    this.height = 8,
  });

  final double value;
  final Color color;
  final Color trackColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: value.clamp(0.0, 1.0)),
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOutCubic,
        builder: (BuildContext context, double v, Widget? child) {
          return LinearProgressIndicator(
            value: v,
            minHeight: height,
            backgroundColor: trackColor,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          );
        },
      ),
    );
  }
}
