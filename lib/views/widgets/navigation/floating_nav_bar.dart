import 'package:flutter/material.dart';

import '../common/glass_card.dart';
import 'nav_bar_item.dart';
import 'nav_destination.dart';

/// Floating white bottom navigation bar; the active item expands into a
/// dark pill with its label (matching the reference design).
class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    super.key,
    required this.index,
    required this.onSelect,
  });

  final int index;
  final ValueChanged<int> onSelect;

  static const List<NavDestination> _items = <NavDestination>[
    NavDestination(Icons.home_outlined, Icons.home_rounded, 'Home'),
    NavDestination(Icons.insights_outlined, Icons.insights_rounded, 'Stats'),
    NavDestination(
      Icons.account_balance_wallet_outlined,
      Icons.account_balance_wallet_rounded,
      'Budget',
    ),
    NavDestination(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      radius: 28,
      blur: 24,
      opacity: 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          for (int i = 0; i < _items.length; i++)
            NavBarItem(
              data: _items[i],
              selected: index == i,
              onTap: () => onSelect(i),
            ),
        ],
      ),
    );
  }
}
