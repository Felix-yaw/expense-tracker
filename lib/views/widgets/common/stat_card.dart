import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Rounded white stat card: a small label row, a large value and optional
/// subtitle / custom body / warm glow behind the value.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    this.value,
    this.subtitle,
    this.subtitleColor = AppColors.positive,
    this.onTap,
    this.glow = false,
    this.child,
  });

  final String label;
  final String? value;
  final String? subtitle;
  final Color subtitleColor;
  final VoidCallback? onTap;
  final bool glow;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: <Widget>[
              if (glow)
                Positioned(
                  right: -30,
                  bottom: -40,
                  child: IgnorePointer(
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: <Color>[
                            AppColors.accent.withValues(alpha: 0.45),
                            AppColors.accent.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          label,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.inkSecondary,
                          ),
                        ),
                      ),
                      if (onTap != null)
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 18,
                          color: AppColors.inkTertiary,
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (value != null)
                    Text(
                      value!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                        color: AppColors.ink,
                      ),
                    ),
                  if (subtitle != null) ...<Widget>[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: subtitleColor,
                      ),
                    ),
                  ],
                  if (child != null) ...<Widget>[
                    const SizedBox(height: 10),
                    child!,
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
