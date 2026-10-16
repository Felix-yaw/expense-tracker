import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Tappable field styled like an input, used to trigger pickers.
class FieldTile extends StatelessWidget {
  const FieldTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.85)),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: <Widget>[
              Icon(icon, size: 18, color: AppColors.inkSecondary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.inkTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
