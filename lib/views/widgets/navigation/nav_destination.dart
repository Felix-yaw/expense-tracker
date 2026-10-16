import 'package:flutter/material.dart';

/// Static definition of a bottom-navigation destination.
class NavDestination {
  const NavDestination(this.icon, this.selectedIcon, this.label);

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
