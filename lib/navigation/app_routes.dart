import 'package:flutter/material.dart';

import '../views/screens/add_expense_screen.dart';
import '../views/screens/expenses_screen.dart';

/// Centralised Navigator helpers.
abstract final class AppRoutes {
  static Future<void> openAddExpense(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const AddExpenseScreen()),
    );
  }

  static Future<void> openExpenses(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ExpensesScreen()),
    );
  }
}
