import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../viewmodels/category_slice.dart';

/// One legend line in the category breakdown: colour, label, amount, share.
class LegendRow extends StatelessWidget {
  const LegendRow({super.key, required this.slice});

  final CategorySlice slice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: slice.category.color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            slice.category.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
        ),
        Text(
          Formatters.currency(slice.amount),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${(slice.fraction * 100).round()}%',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.inkSecondary,
          ),
        ),
      ],
    );
  }
}
