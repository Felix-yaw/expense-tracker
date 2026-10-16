import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// A labelled monetary value used inside the budget hero card.
class BudgetMetric extends StatelessWidget {
  const BudgetMetric({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.inkSecondary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
            color: color,
          ),
        ),
      ],
    );
  }
}
