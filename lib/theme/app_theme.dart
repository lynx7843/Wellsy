import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography scale from the design system (Plus Jakarta Sans).
class AppText {
  AppText._();

  static TextStyle _base(double size, double height, double tracking, FontWeight weight) =>
      GoogleFonts.plusJakartaSans(
        fontSize: size,
        height: height / size,
        letterSpacing: tracking * size,
        fontWeight: weight,
        color: AppColors.onSurface,
      );

  static TextStyle get headlineLgMobile => _base(26, 34, -0.01, FontWeight.w700);
  static TextStyle get headlineSm => _base(18, 24, 0, FontWeight.w600);
  static TextStyle get metricNumeral => _base(28, 32, -0.03, FontWeight.w800);
  static TextStyle get bodyMd => _base(14, 20, 0, FontWeight.w400);
  static TextStyle get bodySm => _base(12, 16, 0.01, FontWeight.w400);
  static TextStyle get labelMd => _base(13, 18, 0.02, FontWeight.w600);
  static TextStyle get labelSm => _base(11, 14, 0.04, FontWeight.w700);
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      surfaceDim: AppColors.surfaceDim,
      surfaceContainerLowest: AppColors.surfaceContainerLowest,
      surfaceContainerLow: AppColors.surfaceContainerLow,
      surfaceContainer: AppColors.surfaceContainer,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
      surfaceContainerHighest: AppColors.surfaceContainerHighest,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.surface,
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      splashFactory: InkSparkle.splashFactory,
    );
  }
}
