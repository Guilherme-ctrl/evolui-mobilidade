import 'package:flutter/material.dart';

class AppTheme {
  static const Color brandPrimary = Color(0xFF0057FF);

  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: brandPrimary),
        useMaterial3: true,
      );
}
