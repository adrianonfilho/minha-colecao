import 'package:flutter/material.dart';

// Paleta com contraste suficiente (teste aproximado)
// Darkened primary to improve contrast (WCAG >= 4.5:1 against white)
const _primary = Color(0xFF155FC8);
const _onPrimary = Color(0xFFFFFFFF);
const _bgLight = Color(0xFFFFFFFF);
const _textLight = Color(0xFF000000);

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: _primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.light,
      primary: _primary,
      onPrimary: _onPrimary,
      background: _bgLight,
      onBackground: _textLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _primary,
      foregroundColor: _onPrimary,
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: _primary),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _primary,
      foregroundColor: _onPrimary,
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: _primary),
  );
}
