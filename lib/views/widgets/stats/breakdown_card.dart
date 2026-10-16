import 'package:flutter/material.dart';

import '../../../core/utils/formatters.dart';
import '../../../viewmodels/category_slice.dart';
import '../../../viewmodels/stats_viewmodel.dart';
import '../common/donut_chart.dart';
import '../common/donut_slice.dart';
import '../common/glass_card.dart';
import 'legend_row.dart';

/// Card holding the donut chart and its legend for the category breakdown.
class BreakdownCard extends StatelessWidget {
  const BreakdownCard({super.key, required this.vm});

  final StatsViewModel vm;

  @override
  Widget build(BuildContext context) {
    final List<CategorySlice> slices = vm.breakdown;

    return GlassCard(
      radius: 24,
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
            LegendRow(slice: slice),
            if (slice != slices.last) const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}
