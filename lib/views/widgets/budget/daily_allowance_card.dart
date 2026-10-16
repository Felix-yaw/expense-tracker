import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../viewmodels/budget_viewmodel.dart';
import '../common/glass_card.dart';

/// Card showing the remaining per-day allowance and days left this month.
class DailyAllowanceCard extends StatelessWidget {
  const DailyAllowanceCard({super.key, required this.vm});

  final BudgetViewModel vm;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 24,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Daily allowance',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.inkSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  Formatters.currency(vm.dailyAllowance),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.0,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${vm.daysLeft} days left this month',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.inkSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: <Color>[
                  AppColors.accent.withValues(alpha: 0.55),
                  AppColors.accent.withValues(alpha: 0.15),
                ],
              ),
            ),
            child: const Icon(
              Icons.wallet_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
