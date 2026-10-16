import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'ambient_blob.dart';

/// Soft, colourful mesh background that sits behind the whole app.
///
/// Glass surfaces blur this layer, so it needs gentle colour to refract.
/// The blobs use radial gradients (soft edges) rather than blur filters, so
/// they are cheap to paint.
class AmbientBackground extends StatelessWidget {
  const AmbientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Color(0xFFF6F5F3), Color(0xFFEDEFF4)],
            ),
          ),
        ),
        Positioned(
          top: -130,
          left: -110,
          child: AmbientBlob(
            size: 360,
            color: AppColors.accent.withValues(alpha: 0.34),
          ),
        ),
        Positioned(
          top: -50,
          right: -120,
          child: AmbientBlob(
            size: 320,
            color: const Color(0xFF6C8CFF).withValues(alpha: 0.24),
          ),
        ),
        Positioned(
          top: 320,
          left: -150,
          child: AmbientBlob(
            size: 320,
            color: const Color(0xFFFFB48A).withValues(alpha: 0.26),
          ),
        ),
        Positioned(
          bottom: -140,
          right: -90,
          child: AmbientBlob(
            size: 360,
            color: const Color(0xFF7BE0B8).withValues(alpha: 0.22),
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}
