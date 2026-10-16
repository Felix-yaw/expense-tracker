import 'package:flutter/material.dart';

/// Immutable definition of a profile menu row.
@immutable
class MenuItem {
  const MenuItem(this.icon, this.title);

  final IconData icon;
  final String title;
}
