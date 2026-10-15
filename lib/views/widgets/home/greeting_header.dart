import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Big "Hi, {name}" greeting with a soft avatar.
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    super.key,
    required this.name,
    this.onAvatarTap,
  });

  final String name;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                const TextSpan(
                  text: 'Hi, ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.ink,
                  ),
                ),
                TextSpan(
                  text: name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            style: const TextStyle(
              fontSize: 34,
              letterSpacing: -1.2,
              height: 1.1,
              color: AppColors.ink,
            ),
          ),
        ),
        GestureDetector(
          onTap: onAvatarTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[AppColors.accent, Color(0xFFFF8A5B)],
              ),
            ),
            child: const Center(
              child: Text(
                'M',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
