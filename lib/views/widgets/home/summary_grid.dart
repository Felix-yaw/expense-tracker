import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../viewmodels/dashboard_viewmodel.dart';
import '../common/stat_card.dart';
import 'mini_bars.dart';

/// The staggered 2×2 summary grid from the reference design.
class SummaryGrid extends StatelessWidget {
  const SummaryGrid({
    super.key,
    required this.viewModel,
    this.onSpentTap,
    this.onTransactionsTap,
  });

  final DashboardViewModel viewModel;
  final VoidCallback? onSpentTap;
  final VoidCallback? onTransactionsTap;

  @override
  Widget build(BuildContext context) {
    final bool under = viewModel.underBudgetDelta >= 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              StatCard(
                label: 'Total spent',
                value: Formatters.currency(viewModel.monthSpent, compact: true),
                subtitle: 'This month',
                subtitleColor: AppColors.inkSecondary,
                glow: true,
                onTap: onSpentTap,
              ),
              const SizedBox(height: 12),
              StatCard(
                label: 'Transactions',
                value: '${viewModel.recentExpenses.length}',
                subtitle: 'Recent',
                subtitleColor: AppColors.inkSecondary,
                onTap: onTransactionsTap,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: <Widget>[
              StatCard(
                label: 'Daily average',
                value: Formatters.currency(viewModel.dailyAverage),
                subtitle: 'per day',
                subtitleColor: AppColors.inkSecondary,
              ),
              const SizedBox(height: 12),
              StatCard(
                label: 'Budget left',
                value: Formatters.currency(viewModel.remaining, compact: true),
                subtitle: under ? 'On track' : 'Over budget',
                subtitleColor: under ? AppColors.positive : AppColors.accent,
                child: MiniBars(values: viewModel.last7DayTotals),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
