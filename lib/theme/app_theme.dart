import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  // Light
  static const Color primary = Color(0xFF2541D9);
  static const Color primaryLight = Color(0xFF4C7BFF);
  static const Color secondary = Color(0xFF10B981);
  static const Color background = Color(0xFFF4F6FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF141A33);

  // Dark
  static const Color darkPrimary = Color(0xFF7C9BFF);
  static const Color darkSecondary = Color(0xFF34D399);
  static const Color darkBackground = Color(0xFF0D1124);
  static const Color darkSurface = Color(0xFF171C36);
  static const Color darkInk = Color(0xFFE8EBFA);

  // Header gradients
  static const List<Color> headerLight = [Color(0xFF2541D9), Color(0xFF4C7BFF)];
  static const List<Color> headerDark = [Color(0xFF1A2A8F), Color(0xFF3A55E0)];
}

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness b) {
    final isDark = b == Brightness.dark;
    final base = ThemeData(brightness: b, useMaterial3: true);

    final primary = isDark ? AppColors.darkPrimary : AppColors.primary;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.secondary;
    final background = isDark ? AppColors.darkBackground : AppColors.background;
    final surface = isDark ? AppColors.darkSurface : AppColors.surface;
    final ink = isDark ? AppColors.darkInk : AppColors.ink;
    final onPrimary = isDark ? AppColors.darkBackground : Colors.white;

    final colorScheme = base.colorScheme.copyWith(
      brightness: b,
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      surface: surface,
      onSurface: ink,
    );

    final text = GoogleFonts.poppinsTextTheme(base.textTheme);
    final textTheme = text.copyWith(
      headlineSmall: text.headlineSmall?.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: ink,
      ),
      titleMedium: text.titleMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ink,
      ),
      bodyMedium: text.bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ink,
      ),
      bodySmall: text.bodySmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ink,
      ),
    );

    return ThemeData(
      brightness: b,
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }
}
