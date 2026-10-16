import '../data/models/expense.dart';
import '../data/models/expense_category.dart';
import 'category_budget.dart';
import 'view_model.dart';

/// Backs the Budget screen.
class BudgetViewModel extends ViewModel {
  BudgetViewModel(super.repository);

  double get limit => repository.budget.monthlyLimit;

  double get spent => ViewModel.sum(
    repository.expenses.where(
      (Expense e) => ViewModel.isSameMonth(e.date, DateTime.now()),
    ),
  );

  double get remaining => (limit - spent).clamp(0, double.infinity);

  double get usedFraction => limit <= 0 ? 0 : (spent / limit).clamp(0.0, 1.0);

  bool get overBudget => spent > limit;

  int get daysLeft {
    final DateTime now = DateTime.now();
    final DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);
    return endOfMonth.difference(now).inDays;
  }

  double get dailyAllowance => daysLeft <= 0 ? 0 : remaining / daysLeft;

  /// Categories that have a defined limit, with their current spend.
  List<CategoryBudget> get categoryBudgets {
    final Map<ExpenseCategory, double> spentPerCategory =
        <ExpenseCategory, double>{};
    for (final Expense e in repository.expenses) {
      if (!ViewModel.isSameMonth(e.date, DateTime.now())) continue;
      spentPerCategory[e.category] =
          (spentPerCategory[e.category] ?? 0) + e.amount;
    }

    return repository.budget.categoryLimits.entries
        .map(
          (MapEntry<ExpenseCategory, double> entry) => CategoryBudget(
            category: entry.key,
            spent: spentPerCategory[entry.key] ?? 0,
            limit: entry.value,
          ),
        )
        .toList()
      ..sort(
        (CategoryBudget a, CategoryBudget b) =>
            b.fraction.compareTo(a.fraction),
      );
  }

  void setMonthlyLimit(double value) {
    repository.setBudget(repository.budget.copyWith(monthlyLimit: value));
  }

  void setCategoryLimit(ExpenseCategory category, double value) {
    final Map<ExpenseCategory, double> limits =
        Map<ExpenseCategory, double>.of(repository.budget.categoryLimits);
    limits[category] = value;
    repository.setBudget(repository.budget.copyWith(categoryLimits: limits));
  }
}
