import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../viewmodels/budget_viewmodel.dart';
import '../widgets/common/category_avatar.dart';
import '../widgets/common/glass_card.dart';
import '../widgets/common/progress_bar.dart';
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
          _HeroBudgetCard(vm: vm),
          const SizedBox(height: 16),
          _DailyAllowanceCard(vm: vm),
          const SizedBox(height: 26),
          const SectionHeader(title: 'By category'),
          const SizedBox(height: 14),
          _CategoryBudgetCard(vm: vm),
        ],
      ),
    );
  }
}

class _HeroBudgetCard extends StatelessWidget {
  const _HeroBudgetCard({required this.vm});

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
              _Metric(
                label: 'Spent',
                value: Formatters.currency(vm.spent),
                color: AppColors.ink,
              ),
              const SizedBox(width: 24),
              _Metric(
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

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.inkSecondary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _DailyAllowanceCard extends StatelessWidget {
  const _DailyAllowanceCard({required this.vm});

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

class _CategoryBudgetCard extends StatelessWidget {
  const _CategoryBudgetCard({required this.vm});

  final BudgetViewModel vm;

  @override
  Widget build(BuildContext context) {
    final List<CategoryBudget> items = vm.categoryBudgets;

    return GlassCard(
      radius: 24,
      padding: const EdgeInsets.all(18),
      child: Column(
        children: <Widget>[
          for (final CategoryBudget item in items) ...<Widget>[
            _CategoryBudgetRow(item: item),
            if (item != items.last) const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}

class _CategoryBudgetRow extends StatelessWidget {
  const _CategoryBudgetRow({required this.item});

  final CategoryBudget item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CategoryAvatar(category: item.category, size: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.category.label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${Formatters.currency(item.spent)} of ${Formatters.currency(item.limit)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.inkSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (item.overBudget)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Over',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.accent,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        ProgressBar(
          value: item.fraction,
          color: item.overBudget ? AppColors.accent : item.category.color,
          height: 8,
        ),
      ],
    );
  }
}
