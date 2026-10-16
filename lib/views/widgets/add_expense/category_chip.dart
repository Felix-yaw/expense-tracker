import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/expense_category.dart';

/// Selectable category pill used in the add-expense form.
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final ExpenseCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? category.color : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? category.color : AppColors.cardBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              category.icon,
              size: 16,
              color: selected ? Colors.white : category.color,
            ),
            const SizedBox(width: 8),
            Text(
              category.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
