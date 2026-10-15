import '../data/models/expense.dart';
import '../data/models/expense_category.dart';
import 'view_model.dart';

/// Backs the full expenses list screen (search + category filter).
class ExpensesViewModel extends ViewModel {
  ExpensesViewModel(super.repository);

  String _query = '';
  ExpenseCategory? _category;

  String get query => _query;
  ExpenseCategory? get category => _category;

  void setQuery(String value) {
    if (_query == value) return;
    _query = value;
    notifyListeners();
  }

  void setCategory(ExpenseCategory? value) {
    if (_category == value) return;
    _category = value;
    notifyListeners();
  }

  List<Expense> get visible {
    final String query = _query.trim().toLowerCase();
    final List<Expense> list = repository.expenses.where((Expense e) {
      final bool matchesCategory = _category == null || e.category == _category;
      final bool matchesQuery =
          query.isEmpty ||
          e.title.toLowerCase().contains(query) ||
          e.note.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();

    list.sort((Expense a, Expense b) => b.date.compareTo(a.date));
    return list;
  }

  double get visibleTotal => ViewModel.sum(visible);

  void remove(String id) => repository.remove(id);
}
