import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'nav_destination.dart';

/// A single item of the floating navigation bar, expanding when selected.
class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final NavDestination data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 18 : 14,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.ink : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              selected ? data.selectedIcon : data.icon,
              size: 22,
              color: selected ? Colors.white : AppColors.inkSecondary,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: selected
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        data.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
