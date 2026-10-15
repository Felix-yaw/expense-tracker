import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Vertical bar chart with rounded bars, optional value labels and a
/// highlighted column.
class BarChart extends StatelessWidget {
  const BarChart({
    super.key,
    required this.labels,
    required this.values,
    this.valueLabels,
    this.highlightIndex = -1,
    this.height = 150,
    this.color = AppColors.accent,
  });

  final List<String> labels;
  final List<double> values;
  final List<String>? valueLabels;
  final int highlightIndex;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double max = values.fold<double>(
      0,
      (double m, double v) => v > m ? v : m,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        for (int i = 0; i < values.length; i++)
          Expanded(
            child: _Bar(
              label: labels[i],
              valueLabel: valueLabels == null ? null : valueLabels![i],
              fraction: max == 0 ? 0 : values[i] / max,
              height: height,
              color: color,
              highlighted: i == highlightIndex,
            ),
          ),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.label,
    required this.valueLabel,
    required this.fraction,
    required this.height,
    required this.color,
    required this.highlighted,
  });

  final String label;
  final String? valueLabel;
  final double fraction;
  final double height;
  final Color color;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    const double barWidth = 16;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (valueLabel != null)
          Text(
            valueLabel!,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: highlighted ? AppColors.ink : AppColors.inkTertiary,
            ),
          ),
        const SizedBox(height: 8),
        SizedBox(
          height: height,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: fraction),
              duration: const Duration(milliseconds: 650),
              curve: Curves.easeOutCubic,
              builder: (BuildContext context, double t, Widget? child) {
                return Container(
                  width: barWidth,
                  height: (height * t).clamp(6.0, height),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(barWidth / 2),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.inkSecondary,
          ),
        ),
      ],
    );
  }
}
