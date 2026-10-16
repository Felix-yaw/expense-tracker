import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../viewmodels/category_budget.dart';
import '../common/category_avatar.dart';
import '../common/progress_bar.dart';

/// A single category row: avatar, spend vs limit and a progress bar.
class CategoryBudgetRow extends StatelessWidget {
  const CategoryBudgetRow({super.key, required this.item});

  final CategoryBudget item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CategoryAvatar(category: item.category, size: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.category.label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${Formatters.currency(item.spent)} of ${Formatters.currency(item.limit)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.inkSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (item.overBudget)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Over',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.accent,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        ProgressBar(
          value: item.fraction,
          color: item.overBudget ? AppColors.accent : item.category.color,
          height: 8,
        ),
      ],
    );
  }
}
