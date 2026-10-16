import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../viewmodels/budget_viewmodel.dart';
import '../common/glass_card.dart';
import '../common/progress_bar.dart';
import 'budget_metric.dart';

/// The large monthly-budget card at the top of the budget screen.
class HeroBudgetCard extends StatelessWidget {
  const HeroBudgetCard({super.key, required this.vm});

  final BudgetViewModel vm;

  @override
  Widget build(BuildContext context) {
    final Color progressColor = vm.overBudget
        ? AppColors.accent
        : AppColors.ink;

    return GlassCard(
      radius: 24,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Monthly budget',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.inkSecondary,
                  ),
                ),
              ),
              Text(
                Formatters.month(DateTime.now()),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.inkSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Formatters.currency(vm.spent, compact: true),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.5,
                      color: AppColors.ink,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'of ${Formatters.currency(vm.limit, compact: true)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.inkSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ProgressBar(value: vm.usedFraction, color: progressColor, height: 10),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              BudgetMetric(
                label: 'Spent',
                value: Formatters.currency(vm.spent),
                color: AppColors.ink,
              ),
              const SizedBox(width: 24),
              BudgetMetric(
                label: 'Remaining',
                value: Formatters.currency(vm.remaining),
                color: vm.overBudget ? AppColors.accent : AppColors.positive,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
