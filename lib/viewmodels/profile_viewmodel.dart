import '../data/models/expense.dart';
import 'view_model.dart';

/// Backs the Profile screen with a few account summary figures.
class ProfileViewModel extends ViewModel {
  ProfileViewModel(super.repository);

  String get userName => 'Miranda';

  String get email => 'miranda@example.com';

  String get memberSince => 'Member since January 2024';

  double get totalTracked => ViewModel.sum(repository.expenses);

  int get transactionCount => repository.expenses.length;

  int get categoryCount =>
      repository.expenses.map((Expense e) => e.category).toSet().length;
}
