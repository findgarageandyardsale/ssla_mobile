import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Based on SSLA Logo
  static const Color primary = Color(0xFFFF6B35); // Orange
  static const Color primaryLight = Color(0xFFFF8A65); // Light Orange
  static const Color primaryDark = Color(0xFFE64A19); // Dark Orange

  // Secondary Colors - Accent colors
  static const Color secondary = Color(0xFF1976D2); // Blue
  static const Color secondaryLight = Color(0xFF42A5F5); // Light Blue
  static const Color secondaryDark = Color(0xFF0D47A1); // Dark Blue

  // Tertiary Colors
  static const Color tertiary = Color(0xFF8B4513); // Saddle Brown
  static const Color tertiaryLight = Color(0xFFA0522D); // Light Brown

  // Neutral Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Colors.white;
  static const Color card = Colors.white;

  // Text Colors
  static const Color textPrimary = Color(
    0xFFE64A19,
  ); // Dark Orange for primary text
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, secondaryLight],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary], // Orange to Blue gradient
  );
}
