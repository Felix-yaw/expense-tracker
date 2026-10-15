import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// A frosted-glass surface.
///
/// Blurs whatever is behind it (the ambient background) and overlays a
/// translucent white fill with a bright hairline border and a soft shadow.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.margin,
    this.radius = 24,
    this.blur = 16,
    this.opacity = 0.55,
    this.borderOpacity = 0.75,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final double blur;
  final double opacity;
  final double borderOpacity;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(radius);

    Widget surface = DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: opacity),
        borderRadius: borderRadius,
        border: Border.all(
          color: Colors.white.withValues(alpha: borderOpacity),
        ),
      ),
      child: Padding(
        padding: padding,
        child: onTap == null
            ? child
            : Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: borderRadius,
                  onTap: onTap,
                  child: child,
                ),
              ),
      ),
    );

    surface = ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: surface,
      ),
    );

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: AppColors.cardShadow,
      ),
      child: surface,
    );
  }
}
