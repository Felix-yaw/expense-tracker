import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Thin vertical divider between profile statistics.
class StatDivider extends StatelessWidget {
  const StatDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 36, color: AppColors.divider);
  }
}
