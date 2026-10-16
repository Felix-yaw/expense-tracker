import 'package:flutter/material.dart';

import '../../../core/utils/formatters.dart';
import '../../../viewmodels/profile_viewmodel.dart';
import '../common/glass_card.dart';
import 'profile_stat.dart';
import 'stat_divider.dart';

/// Card with three aggregate statistics (tracked, records, categories).
class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({super.key, required this.vm});

  final ProfileViewModel vm;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 24,
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Row(
        children: <Widget>[
          ProfileStat(
            value: Formatters.currency(vm.totalTracked, compact: true),
            label: 'Tracked',
          ),
          const StatDivider(),
          ProfileStat(value: '${vm.transactionCount}', label: 'Records'),
          const StatDivider(),
          ProfileStat(value: '${vm.categoryCount}', label: 'Categories'),
        ],
      ),
    );
  }
}
