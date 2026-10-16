import '../data/models/expense_category.dart';

/// Per-category spend measured against its configured limit.
class CategoryBudget {
  const CategoryBudget({
    required this.category,
    required this.spent,
    required this.limit,
  });

  final ExpenseCategory category;
  final double spent;
  final double limit;

  double get fraction => limit <= 0 ? 0 : (spent / limit).clamp(0.0, 1.0);

  bool get overBudget => limit > 0 && spent > limit;
}
