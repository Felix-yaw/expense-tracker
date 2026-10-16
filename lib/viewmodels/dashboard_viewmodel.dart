import '../core/utils/formatters.dart';
import '../data/models/budget.dart';
import '../data/models/expense.dart';
import 'period_filter.dart';
import 'view_model.dart';

/// Backs the Home/dashboard screen.
class DashboardViewModel extends ViewModel {
  DashboardViewModel(super.repository);

  PeriodFilter _filter = PeriodFilter.all;

  PeriodFilter get filter => _filter;

  String get userName => 'Miranda';

  Budget get budget => repository.budget;

  List<Expense> get _thisMonth => repository.expenses
      .where((Expense e) => ViewModel.isSameMonth(e.date, DateTime.now()))
      .toList(growable: false);

  double get monthSpent => ViewModel.sum(_thisMonth);

  double get budgetLimit => budget.monthlyLimit;

  double get remaining => (budgetLimit - monthSpent).clamp(0, double.infinity);

  double get budgetUsedFraction =>
      budgetLimit <= 0 ? 0 : (monthSpent / budgetLimit).clamp(0.0, 1.0);

  /// Positive when under budget, negative when over.
  double get underBudgetDelta => budgetLimit - monthSpent;

  int get _daysElapsed => DateTime.now().day;

  double get dailyAverage => _daysElapsed == 0 ? 0 : monthSpent / _daysElapsed;

  /// Spend for each of the last 7 days (oldest → newest).
  List<double> get last7DayTotals {
    final DateTime today = ViewModel.startOfDay(DateTime.now());
    return List<double>.generate(7, (int i) {
      final DateTime day = today.subtract(Duration(days: 6 - i));
      return ViewModel.sum(
        repository.expenses.where(
          (Expense e) => ViewModel.startOfDay(e.date) == day,
        ),
      );
    });
  }

  List<String> get last7DayLabels {
    final DateTime today = ViewModel.startOfDay(DateTime.now());
    return List<String>.generate(7, (int i) {
      final DateTime day = today.subtract(Duration(days: 6 - i));
      return Formatters.dayOfWeekShort(day);
    });
  }

  void setFilter(PeriodFilter filter) {
    if (_filter == filter) return;
    _filter = filter;
    notifyListeners();
  }

  List<Expense> get recentExpenses {
    final DateTime now = DateTime.now();
    final Iterable<Expense> source = repository.expenses.where((Expense e) {
      switch (_filter) {
        case PeriodFilter.all:
          return true;
        case PeriodFilter.week:
          return !e.date.isBefore(ViewModel.startOfWeek(now));
        case PeriodFilter.month:
          return ViewModel.isSameMonth(e.date, now);
      }
    });
    final List<Expense> list = source.toList()
      ..sort((Expense a, Expense b) => b.date.compareTo(a.date));
    return list.take(6).toList(growable: false);
  }

  double get filteredTotal => ViewModel.sum(
    repository.expenses.where((Expense e) {
      switch (_filter) {
        case PeriodFilter.all:
          return true;
        case PeriodFilter.week:
          return !e.date.isBefore(ViewModel.startOfWeek(DateTime.now()));
        case PeriodFilter.month:
          return ViewModel.isSameMonth(e.date, DateTime.now());
      }
    }),
  );
}
