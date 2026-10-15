import 'package:flutter/foundation.dart';

import 'expense_category.dart';

/// Monthly spending budget, optionally split per category.
@immutable
class Budget {
  const Budget({
    required this.monthlyLimit,
    this.categoryLimits = const <ExpenseCategory, double>{},
  });

  final double monthlyLimit;
  final Map<ExpenseCategory, double> categoryLimits;

  double limitFor(ExpenseCategory category) =>
      categoryLimits[category] ?? 0;

  Budget copyWith({
    double? monthlyLimit,
    Map<ExpenseCategory, double>? categoryLimits,
  }) {
    return Budget(
      monthlyLimit: monthlyLimit ?? this.monthlyLimit,
      categoryLimits: categoryLimits ?? this.categoryLimits,
    );
  }
}
