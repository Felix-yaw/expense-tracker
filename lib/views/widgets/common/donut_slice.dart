import 'package:flutter/material.dart';

/// One arc of a [DonutChart].
class DonutSlice {
  const DonutSlice({required this.color, required this.fraction});

  final Color color;
  final double fraction;
}
