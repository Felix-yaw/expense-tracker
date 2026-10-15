import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'data/repositories/expense_repository.dart';
import 'views/screens/root_shell.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

/// App root. Provides the single [ExpenseRepository] (the MVVM model layer);
/// the ViewModels depend on it and are provided per screen/tab.
class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExpenseRepository>(
      create: (_) => ExpenseRepository(),
      child: MaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const RootShell(),
      ),
    );
  }
}
