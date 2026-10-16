import 'package:flutter/material.dart';

import '../../../viewmodels/budget_viewmodel.dart';
import '../../../viewmodels/category_budget.dart';
import '../common/glass_card.dart';
import 'category_budget_row.dart';

/// Card listing per-category budgets.
class CategoryBudgetCard extends StatelessWidget {
  const CategoryBudgetCard({super.key, required this.vm});

  final BudgetViewModel vm;

  @override
  Widget build(BuildContext context) {
    final List<CategoryBudget> items = vm.categoryBudgets;

    return GlassCard(
      radius: 24,
      padding: const EdgeInsets.all(18),
      child: Column(
        children: <Widget>[
          for (final CategoryBudget item in items) ...<Widget>[
            CategoryBudgetRow(item: item),
            if (item != items.last) const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}
