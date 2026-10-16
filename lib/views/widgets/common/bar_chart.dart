import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'chart_bar.dart';

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
            child: ChartBar(
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
