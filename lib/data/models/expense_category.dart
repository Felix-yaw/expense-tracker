import 'package:flutter/material.dart';

/// Spending categories, each with a display label, icon and accent colour.
enum ExpenseCategory {
  food('Food & Drink', Icons.ramen_dining_rounded, Color(0xFFE8511C)),
  transport('Transport', Icons.directions_car_filled_rounded, Color(0xFF3B82F6)),
  shopping('Shopping', Icons.shopping_bag_rounded, Color(0xFF9B5DE5)),
  bills('Bills & Utilities', Icons.receipt_long_rounded, Color(0xFFF5A623)),
  health('Health', Icons.favorite_rounded, Color(0xFF2FBE7E)),
  entertainment('Entertainment', Icons.movie_rounded, Color(0xFFEC4899)),
  education('Education', Icons.school_rounded, Color(0xFF14B8A6)),
  other('Other', Icons.more_horiz_rounded, Color(0xFF8A8C93));

  const ExpenseCategory(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}
