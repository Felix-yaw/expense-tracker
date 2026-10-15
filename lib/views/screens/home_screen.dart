import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/expense.dart';
import '../../navigation/app_routes.dart';
import '../../viewmodels/dashboard_viewmodel.dart';
import '../widgets/common/pill_tab_bar.dart';
import '../widgets/common/section_header.dart';
import '../widgets/home/greeting_header.dart';
import '../widgets/home/summary_grid.dart';
import '../widgets/home/transaction_tile.dart';

/// Home/dashboard tab.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardViewModel viewModel = context.watch<DashboardViewModel>();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
        children: <Widget>[
          GreetingHeader(name: viewModel.userName),
          const SizedBox(height: 24),
          SummaryGrid(
            viewModel: viewModel,
            onSpentTap: () => AppRoutes.openExpenses(context),
            onTransactionsTap: () => AppRoutes.openExpenses(context),
          ),
          const SizedBox(height: 26),
          SectionHeader(
            title: 'Recent activity',
            actionLabel: 'See all',
            onAction: () => AppRoutes.openExpenses(context),
          ),
          const SizedBox(height: 14),
          PillTabBar<PeriodFilter>(
            items: PeriodFilter.values,
            selected: viewModel.filter,
            labelOf: (PeriodFilter f) => f.label,
            onSelect: viewModel.setFilter,
          ),
          const SizedBox(height: 6),
          for (final Expense expense in viewModel.recentExpenses)
            TransactionTile(
              expense: expense,
              onTap: () => AppRoutes.openExpenses(context),
            ),
        ],
      ),
    );
  }
}
