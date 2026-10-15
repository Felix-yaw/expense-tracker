import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Round soft icon button used for header actions and overlays.
class SoftIconButton extends StatelessWidget {
  const SoftIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.background = AppColors.surface,
    this.color = AppColors.ink,
    this.size = 44,
    this.iconSize = 20,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color background;
  final Color color;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, size: iconSize, color: color),
        ),
      ),
    );
  }
}
