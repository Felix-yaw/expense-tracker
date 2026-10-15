import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../viewmodels/dashboard_viewmodel.dart';
import '../common/stat_card.dart';

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
                child: _MiniBars(values: viewModel.last7DayTotals),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Tiny 7-bar sparkline used inside the budget card.
class _MiniBars extends StatelessWidget {
  const _MiniBars({required this.values});

  final List<double> values;

  @override
  Widget build(BuildContext context) {
    final double max = values.fold<double>(
      0,
      (double m, double v) => v > m ? v : m,
    );

    return SizedBox(
      height: 34,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          for (int i = 0; i < values.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  height: max == 0 ? 4 : (values[i] / max * 34).clamp(4.0, 34.0),
                  decoration: BoxDecoration(
                    color: i == values.length - 1
                        ? AppColors.accent
                        : AppColors.accentSoft,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
