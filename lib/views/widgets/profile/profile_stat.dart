import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// A single value/label statistic shown inside a stats card.
class ProfileStat extends StatelessWidget {
  const ProfileStat({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.inkSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
