import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/expense_repository.dart';
import '../../viewmodels/expenses_viewmodel.dart';
import '../widgets/expenses/expenses_view.dart';

/// Full list of expenses with search + category filter.
class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExpensesViewModel>(
      create: (BuildContext ctx) =>
          ExpensesViewModel(ctx.read<ExpenseRepository>()),
      child: const ExpensesView(),
    );
  }
}
