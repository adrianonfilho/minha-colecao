import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  ThemeService._private();
  static final ThemeService instance = ThemeService._private();

  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString('theme') ?? 'system';
    themeMode.value = _fromString(s);
  }

  ThemeMode _fromString(String s) {
    switch (s) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  String _toString(ThemeMode m) {
    switch (m) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
      default:
        return 'system';
    }
  }

  Future<void> setThemeMode(ThemeMode m) async {
    themeMode.value = m;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', _toString(m));
  }
}
