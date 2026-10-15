import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../data/repositories/expense_repository.dart';
import '../../navigation/app_routes.dart';
import '../../viewmodels/budget_viewmodel.dart';
import '../../viewmodels/dashboard_viewmodel.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../../viewmodels/stats_viewmodel.dart';
import '../widgets/navigation/floating_nav_bar.dart';
import 'budget_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'stats_screen.dart';

/// Root scaffold hosting the four primary tabs.
///
/// The tab ViewModels are created once here and kept alive by the
/// [IndexedStack], so switching tabs never resets their state.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  void _onSelect(int index) {
    if (index == _index) return;
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<ChangeNotifier>>[
        ChangeNotifierProvider<DashboardViewModel>(
          create: (BuildContext ctx) =>
              DashboardViewModel(ctx.read<ExpenseRepository>()),
        ),
        ChangeNotifierProvider<StatsViewModel>(
          create: (BuildContext ctx) =>
              StatsViewModel(ctx.read<ExpenseRepository>()),
        ),
        ChangeNotifierProvider<BudgetViewModel>(
          create: (BuildContext ctx) =>
              BudgetViewModel(ctx.read<ExpenseRepository>()),
        ),
        ChangeNotifierProvider<ProfileViewModel>(
          create: (BuildContext ctx) =>
              ProfileViewModel(ctx.read<ExpenseRepository>()),
        ),
      ],
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: _index,
          children: const <Widget>[
            HomeScreen(),
            StatsScreen(),
            BudgetScreen(),
            ProfileScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => AppRoutes.openAddExpense(context),
          backgroundColor: AppColors.ink,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(Icons.add_rounded, size: 28),
        ),
        bottomNavigationBar: FloatingNavBar(
          index: _index,
          onSelect: _onSelect,
        ),
      ),
    );
  }
}
