import '../data/models/expense.dart';
import '../data/models/expense_category.dart';
import 'view_model.dart';

/// Backs the Add-expense form.
class AddExpenseViewModel extends ViewModel {
  AddExpenseViewModel(super.repository);

  String _title = '';
  String _amount = '';
  ExpenseCategory _category = ExpenseCategory.food;
  DateTime _date = DateTime.now();
  String _note = '';
  String _account = 'Main account';

  String get title => _title;
  String get amount => _amount;
  ExpenseCategory get category => _category;
  DateTime get date => _date;
  String get note => _note;
  String get account => _account;

  double? get parsedAmount {
    final double? value = double.tryParse(_amount.trim());
    return (value == null || value <= 0) ? null : value;
  }

  bool get isValid => _title.trim().isNotEmpty && parsedAmount != null;

  void setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  void setAmount(String value) {
    _amount = value;
    notifyListeners();
  }

  void setCategory(ExpenseCategory value) {
    _category = value;
    notifyListeners();
  }

  void setDate(DateTime value) {
    _date = value;
    notifyListeners();
  }

  void setNote(String value) {
    _note = value;
    notifyListeners();
  }

  void setAccount(String value) {
    _account = value;
    notifyListeners();
  }

  /// Persists the expense. Returns `false` when the form is invalid.
  bool save() {
    final double? value = parsedAmount;
    if (_title.trim().isEmpty || value == null) return false;

    repository.add(
      Expense(
        id: repository.nextId(),
        title: _title.trim(),
        amount: value,
        category: _category,
        date: _date,
        note: _note.trim(),
        account: _account,
      ),
    );
    return true;
  }
}
