import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'donut_slice.dart';

/// Paints the animated arcs of a [DonutChart].
class DonutPainter extends CustomPainter {
  DonutPainter({
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
    final Rect arcRect = Rect.fromCircle(center: rect.center, radius: radius);

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
  bool shouldRepaint(DonutPainter old) =>
      old.progress != progress || old.slices != slices;
}
