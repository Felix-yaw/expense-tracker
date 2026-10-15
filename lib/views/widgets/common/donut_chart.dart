import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// One arc of a [DonutChart].
class DonutSlice {
  const DonutSlice({required this.color, required this.fraction});
  final Color color;
  final double fraction;
}

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
            painter: _DonutPainter(
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

class _DonutPainter extends CustomPainter {
  _DonutPainter({
    required this.slices,
    required this.strokeWidth,
    required this.progress,
  });

  final List<DonutSlice> slices;
  final double strokeWidth;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final double radius = (math.min(size.width, size.height) - strokeWidth) / 2;
    final Rect arcRect = Rect.fromCircle(
      center: rect.center,
      radius: radius,
    );

    final Paint track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = AppColors.surfaceMuted;
    canvas.drawCircle(rect.center, radius, track);

    double start = -math.pi / 2;
    for (final DonutSlice slice in slices) {
      final double sweep = slice.fraction * 2 * math.pi * progress;
      final Paint paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..color = slice.color;
      canvas.drawArc(arcRect, start, sweep, false, paint);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(_DonutPainter old) =>
      old.progress != progress || old.slices != slices;
}
