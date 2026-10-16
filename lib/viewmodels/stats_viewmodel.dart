import '../core/utils/formatters.dart';
import '../data/models/expense.dart';
import '../data/models/expense_category.dart';
import 'category_slice.dart';
import 'daily_bar.dart';
import 'view_model.dart';

/// Backs the Statistics screen.
class StatsViewModel extends ViewModel {
  StatsViewModel(super.repository);

  double get monthTotal => ViewModel.sum(
    repository.expenses.where((Expense e) {
      return ViewModel.isSameMonth(e.date, DateTime.now());
    }),
  );

  double get weekTotal => ViewModel.sum(
    repository.expenses.where((Expense e) {
      return !e.date.isBefore(ViewModel.startOfWeek(DateTime.now()));
    }),
  );

  double get averagePerDay => monthTotal / DateTime.now().day;

  /// Mon → Sun totals for the current week.
  List<DailyBar> get weeklyBars {
    final DateTime weekStart = ViewModel.startOfWeek(DateTime.now());
    return List<DailyBar>.generate(7, (int i) {
      final DateTime day = weekStart.add(Duration(days: i));
      final double value = ViewModel.sum(
        repository.expenses.where(
          (Expense e) => ViewModel.startOfDay(e.date) == day,
        ),
      );
      return DailyBar(
        label: Formatters.dayOfWeekShort(day),
        value: value,
        date: day,
      );
    });
  }

  double get weeklyMax {
    double max = 0;
    for (final DailyBar bar in weeklyBars) {
      if (bar.value > max) max = bar.value;
    }
    return max;
  }

  /// Category breakdown for the current month, largest first.
  List<CategorySlice> get breakdown {
    final Map<ExpenseCategory, double> totals = <ExpenseCategory, double>{};
    for (final Expense e in repository.expenses) {
      if (!ViewModel.isSameMonth(e.date, DateTime.now())) continue;
      totals[e.category] = (totals[e.category] ?? 0) + e.amount;
    }

    final double total = monthTotal;
    final List<CategorySlice> slices = totals.entries
        .map(
          (MapEntry<ExpenseCategory, double> entry) => CategorySlice(
            category: entry.key,
            amount: entry.value,
            fraction: total == 0 ? 0 : entry.value / total,
          ),
        )
        .toList()
      ..sort((CategorySlice a, CategorySlice b) => b.amount.compareTo(a.amount));
    return slices;
  }

  ExpenseCategory? get topCategory =>
      breakdown.isEmpty ? null : breakdown.first.category;

  int get transactionCount {
    final int month = DateTime.now().month;
    final int year = DateTime.now().year;
    return repository.expenses
        .where((Expense e) => e.date.month == month && e.date.year == year)
        .length;
  }
}
