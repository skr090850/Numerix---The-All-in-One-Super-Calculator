import 'package:flutter/material.dart';

// Yeh class poore app mein istemal hone wale colors ko define karti hai.
// Naya Theme: Teal & Slate
class AppColors {
  // Is class ka object na ban paye, isliye private constructor.
  AppColors._();

  // --- Light Theme Colors ---
  static const Color primaryLight = Color(0xFF00897B); // Deep Teal
  static const Color backgroundLight = Color(0xFFF5F5F5); // Very Light Grey
  static const Color cardLight = Color(0xFFFFFFFF); // White
  static const Color textLight = Color(0xFF263238); // Dark Slate Grey
  static const Color accentLight = Color(0xFFFFAB40); // Amber Accent

  // --- Dark Theme Colors ---
  static const Color primaryDark = Color(0xFF4DB6AC); // Lighter Teal
  static const Color backgroundDark = Color(0xFF212121); // Very Dark Grey
  static const Color cardDark = Color(0xFF303030); // Darker Grey
  static const Color textDark = Color(0xFFE0E0E0); // Light Grey
  static const Color accentDark = Color(0xFFFFC107); // Brighter Amber
}
