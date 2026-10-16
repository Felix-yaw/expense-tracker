import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../viewmodels/budget_viewmodel.dart';
import '../widgets/budget/category_budget_card.dart';
import '../widgets/budget/daily_allowance_card.dart';
import '../widgets/budget/hero_budget_card.dart';
import '../widgets/common/section_header.dart';

/// Budget tab: monthly limit, daily allowance and per-category progress.
class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BudgetViewModel vm = context.watch<BudgetViewModel>();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
        children: <Widget>[
          const Text(
            'Budget',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              letterSpacing: -1.0,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 20),
          HeroBudgetCard(vm: vm),
          const SizedBox(height: 16),
          DailyAllowanceCard(vm: vm),
          const SizedBox(height: 26),
          const SectionHeader(title: 'By category'),
          const SizedBox(height: 14),
          CategoryBudgetCard(vm: vm),
        ],
      ),
    );
  }
}
