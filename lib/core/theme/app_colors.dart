import 'package:flutter/material.dart';

/// Design tokens for the expense tracker.
///
/// A soft light-gray canvas with white cards, near-black ink and a single
/// vivid orange accent — matching the reference "fitness tracker" aesthetic.
abstract final class AppColors {
  static const Color background = Color(0xFFF1F2F4);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF4F5F7);

  static const Color ink = Color(0xFF131417);
  static const Color inkSecondary = Color(0xFF8A8C93);
  static const Color inkTertiary = Color(0xFFB4B6BC);

  static const Color accent = Color(0xFFE8511C);
  static const Color accentSoft = Color(0xFFFBE3D9);

  static const Color positive = Color(0xFF2FBE7E);
  static const Color positiveSoft = Color(0xFFE1F6EC);
  static const Color warning = Color(0xFFF5A623);

  static const Color divider = Color(0xFFECEDF0);
  static const Color cardBorder = Color(0x0F000000);

  /// Very soft ambient card shadow.
  static const List<BoxShadow> cardShadow = <BoxShadow>[
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  /// Warm glow used behind key accent numbers.
  static const List<BoxShadow> glowAccent = <BoxShadow>[
    BoxShadow(
      color: Color(0x40E8511C),
      blurRadius: 24,
      offset: Offset(0, 10),
    ),
  ];
}
