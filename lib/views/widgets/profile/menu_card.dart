import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../common/glass_card.dart';
import 'menu_item.dart';

/// Glass card listing tappable menu rows.
class MenuCard extends StatelessWidget {
  const MenuCard({super.key, required this.items});

  final List<MenuItem> items;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 24,
      padding: EdgeInsets.zero,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            for (int i = 0; i < items.length; i++) ...<Widget>[
              ListTile(
                leading: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(items[i].icon, size: 20, color: AppColors.ink),
                ),
                title: Text(
                  items[i].title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.inkTertiary,
                ),
                onTap: () => ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('${items[i].title} coming soon')),
                  ),
              ),
              if (i != items.length - 1) const Divider(height: 1, indent: 70),
            ],
          ],
        ),
      ),
    );
  }
}
