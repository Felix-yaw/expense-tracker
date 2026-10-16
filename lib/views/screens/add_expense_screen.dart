import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/expense_repository.dart';
import '../../viewmodels/add_expense_viewmodel.dart';
import '../widgets/add_expense/add_expense_view.dart';

/// Add-expense form screen; provides its view-model and hosts the form.
class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddExpenseViewModel>(
      create: (BuildContext ctx) =>
          AddExpenseViewModel(ctx.read<ExpenseRepository>()),
      child: const AddExpenseView(),
    );
  }
}
