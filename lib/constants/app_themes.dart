// 🎨 Lớp 1: Theme Màu

import 'package:flutter/material.dart';

enum AppThemeType {
  techBlue,
  deepOcean,
  sunset,
  midnight,
  forest,
  lightMode,
}

class AppColorScheme {
  final String name;
  final Color bgDark;
  final Color cardBg;
  final Color primary;
  final Color secondary;
  final Color textWhite;
  final Color textGray;
  final Color success;
  final Color warning;
  final Color error;

  const AppColorScheme({
    required this.name,
    required this.bgDark,
    required this.cardBg,
    required this.primary,
    required this.secondary,
    required this.textWhite,
    required this.textGray,
    required this.success,
    required this.warning,
    required this.error,
  });
}

class AppThemes {
  static const Map<AppThemeType, AppColorScheme> themes = {
    AppThemeType.techBlue: AppColorScheme(
      name: 'Xanh Công Nghệ',
      bgDark: Color(0xFF0A0E1F),
      cardBg: Color(0xFF121A33),
      primary: Color(0xFF25B0F0),
      secondary: Color(0xFF3A7BD5),
      textWhite: Color(0xFFFFFFFF),
      textGray: Color(0xFF94A3B8),
      success: Color(0xFF22C55E),
      warning: Color(0xFFF59E0B),
      error: Color(0xFFEF4444),
    ),
    AppThemeType.deepOcean: AppColorScheme(
      name: 'Biển Sâu',
      bgDark: Color(0xFF0F1C2E),
      cardBg: Color(0xFF1A2C42),
      primary: Color(0xFF00D9FF),
      secondary: Color(0xFF008891),
      textWhite: Color(0xFFFFFFFF),
      textGray: Color(0xFF8FB3D1),
      success: Color(0xFF34D399),
      warning: Color(0xFFFBBF24),
      error: Color(0xFFF87171),
    ),
    AppThemeType.sunset: AppColorScheme(
      name: 'Hoàng Hôn',
      bgDark: Color(0xFF1C1410),
      cardBg: Color(0xFF2E2018),
      primary: Color(0xFFFF7A50),
      secondary: Color(0xFFFFB347),
      textWhite: Color(0xFFFFFFFF),
      textGray: Color(0xFFC8A080),
      success: Color(0xFF6EE7B7),
      warning: Color(0xFFFFD166),
      error: Color(0xFFFF6B6B),
    ),
    AppThemeType.midnight: AppColorScheme(
      name: 'Nửa Đêm',
      bgDark: Color(0xFF050505),
      cardBg: Color(0xFF1A1A1A),
      primary: Color(0xFF6366F1),
      secondary: Color(0xFFA5B4FC),
      textWhite: Color(0xFFFFFFFF),
      textGray: Color(0xFF71717A),
      success: Color(0xFF10B981),
      warning: Color(0xFFF59E0B),
      error: Color(0xFFDC2626),
    ),
    AppThemeType.forest: AppColorScheme(
      name: 'Rừng Xanh',
      bgDark: Color(0xFF0F1A0F),
      cardBg: Color(0xFF1A2E1A),
      primary: Color(0xFF4ADE80),
      secondary: Color(0xFF86EFAC),
      textWhite: Color(0xFFFFFFFF),
      textGray: Color(0xFF90A990),
      success: Color(0xFF34D399),
      warning: Color(0xFFFBBF24),
      error: Color(0xFFF87171),
    ),
    AppThemeType.lightMode: AppColorScheme(
      name: 'Sáng',
      bgDark: Color(0xFFF8FAFC),
      cardBg: Color(0xFFFFFFFF),
      primary: Color(0xFF2563EB),
      secondary: Color(0xFF60A5FA),
      textWhite: Color(0xFF1F2937),
      textGray: Color(0xFF6B7280),
      success: Color(0xFF16A34A),
      warning: Color(0xFFD97706),
      error: Color(0xFFDC2626),
    ),
  };

  static AppColorScheme getColors(AppThemeType type) => themes[type]!;
  static String getThemeName(AppThemeType type) => themes[type]!.name;
  static List<AppThemeType> get all => AppThemeType.values;
}