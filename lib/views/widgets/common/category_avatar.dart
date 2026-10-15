import 'package:flutter/material.dart';

import '../../../data/models/expense_category.dart';

/// Circular category icon tinted with the category's colour.
class CategoryAvatar extends StatelessWidget {
  const CategoryAvatar({super.key, required this.category, this.size = 44});

  final ExpenseCategory category;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: category.color.withValues(alpha: 0.14),
        shape: BoxShape.circle,
      ),
      child: Icon(
        category.icon,
        size: size * 0.46,
        color: category.color,
      ),
    );
  }
}
