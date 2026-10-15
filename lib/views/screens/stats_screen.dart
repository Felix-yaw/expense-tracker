import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../viewmodels/stats_viewmodel.dart';
import '../widgets/common/bar_chart.dart';
import '../widgets/common/donut_chart.dart';
import '../widgets/common/section_header.dart';
import '../widgets/common/stat_card.dart';

/// Statistics tab: weekly bar chart and category breakdown.
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StatsViewModel vm = context.watch<StatsViewModel>();
    final List<DailyBar> bars = vm.weeklyBars;
    final int todayIndex = DateTime.now().weekday - 1;

    final DateTime weekStart = DateTime.now().subtract(
      Duration(days: DateTime.now().weekday - 1),
    );
    final DateTime weekEnd = weekStart.add(const Duration(days: 6));

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
        children: <Widget>[
          const Text(
            'Statistics',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              letterSpacing: -1.0,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 20),

          // Weekly chart card
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: AppColors.cardShadow,
            ),
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        'Weekly spending',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    Text(
                      Formatters.dateRange(weekStart, weekEnd),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.inkSecondary,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: AppColors.inkTertiary,
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                BarChart(
                  labels: bars.map((DailyBar b) => b.label).toList(),
                  values: bars.map((DailyBar b) => b.value).toList(),
                  valueLabels: bars
                      .map(
                        (DailyBar b) => b.value == 0
                            ? ''
                            : Formatters.currency(b.value, compact: true),
                      )
                      .toList(),
                  highlightIndex: todayIndex,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: <Widget>[
              Expanded(
                child: StatCard(
                  label: 'This month',
                  value: Formatters.currency(vm.monthTotal, compact: true),
                  subtitle: '${vm.transactionCount} transactions',
                  subtitleColor: AppColors.inkSecondary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  label: 'Daily average',
                  value: Formatters.currency(vm.averagePerDay),
                  subtitle: 'this month',
                  subtitleColor: AppColors.inkSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),

          const SectionHeader(title: 'Where it goes'),
          const SizedBox(height: 14),
          _BreakdownCard(vm: vm),
        ],
      ),
    );
  }
}

class _BreakdownCard extends StatelessWidget {
  const _BreakdownCard({required this.vm});

  final StatsViewModel vm;

  @override
  Widget build(BuildContext context) {
    final List<CategorySlice> slices = vm.breakdown;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.cardShadow,
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        children: <Widget>[
          DonutChart(
            slices: slices
                .map(
                  (CategorySlice s) =>
                      DonutSlice(color: s.category.color, fraction: s.fraction),
                )
                .toList(),
            centerTitle: Formatters.currency(vm.monthTotal, compact: true),
            centerSubtitle: 'this month',
          ),
          const SizedBox(height: 20),
          for (final CategorySlice slice in slices) ...<Widget>[
            _LegendRow(slice: slice),
            if (slice != slices.last) const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.slice});

  final CategorySlice slice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: slice.category.color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            slice.category.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
        ),
        Text(
          Formatters.currency(slice.amount),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${(slice.fraction * 100).round()}%',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.inkSecondary,
          ),
        ),
      ],
    );
  }
}
