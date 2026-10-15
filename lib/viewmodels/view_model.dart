import 'package:flutter/foundation.dart';

import '../data/models/expense.dart';
import '../data/repositories/expense_repository.dart';

/// Base class for all ViewModels.
///
/// It subscribes to the single [ExpenseRepository] and re-notifies, so any
/// mutation anywhere in the app keeps every observing screen in sync.
abstract class ViewModel extends ChangeNotifier {
  ViewModel(this.repository) {
    repository.addListener(_onRepositoryChanged);
  }

  @protected
  final ExpenseRepository repository;

  void _onRepositoryChanged() => notifyListeners();

  /// Convenience: expenses that fall inside the same month as their date.
  static bool isSameMonth(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month;

  static DateTime startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  /// Monday-based start of the week containing [date].
  static DateTime startOfWeek(DateTime date) {
    final DateTime day = startOfDay(date);
    return day.subtract(Duration(days: day.weekday - 1));
  }

  static double sum(Iterable<Expense> expenses) =>
      expenses.fold(0, (double total, Expense e) => total + e.amount);

  @override
  void dispose() {
    repository.removeListener(_onRepositoryChanged);
    super.dispose();
  }
}
