import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Small bold label that sits above a form field.
class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.inkSecondary,
      ),
    );
  }
}
