import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'donut_painter.dart';
import 'donut_slice.dart';

/// Animated donut chart with optional centred labels.
class DonutChart extends StatelessWidget {
  const DonutChart({
    super.key,
    required this.slices,
    this.size = 168,
    this.strokeWidth = 22,
    this.centerTitle,
    this.centerSubtitle,
  });

  final List<DonutSlice> slices;
  final double size;
  final double strokeWidth;
  final String? centerTitle;
  final String? centerSubtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeOutCubic,
        builder: (BuildContext context, double t, Widget? child) {
          return CustomPaint(
            painter: DonutPainter(
              slices: slices,
              strokeWidth: strokeWidth,
              progress: t,
            ),
            child: child,
          );
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (centerTitle != null)
                Text(
                  centerTitle!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                    color: AppColors.ink,
                  ),
                ),
              if (centerSubtitle != null)
                Text(
                  centerSubtitle!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.inkSecondary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
