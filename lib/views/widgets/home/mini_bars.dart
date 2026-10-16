import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Tiny 7-bar sparkline used inside the budget card of [SummaryGrid].
class MiniBars extends StatelessWidget {
  const MiniBars({super.key, required this.values});

  final List<double> values;

  @override
  Widget build(BuildContext context) {
    final double max = values.fold<double>(
      0,
      (double m, double v) => v > m ? v : m,
    );

    return SizedBox(
      height: 34,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          for (int i = 0; i < values.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  height: max == 0 ? 4 : (values[i] / max * 34).clamp(4.0, 34.0),
                  decoration: BoxDecoration(
                    color: i == values.length - 1
                        ? AppColors.accent
                        : AppColors.accentSoft,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
