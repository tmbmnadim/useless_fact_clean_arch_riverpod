import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

final appThemeProvider = Provider((_) => AppTheme());

/// Exposes the active `ThemeData`.
final themeProvider = NotifierProvider<ThemeNotifier, ThemeData>(
  ThemeNotifier.new,
);

class ThemeNotifier extends Notifier<ThemeData> {
  late final AppTheme _themeService;
  AppThemeType _current = AppThemeType.calm;

  // ignore: avoid_public_notifier_properties
  AppThemeType get current => _current;
  // ignore: avoid_public_notifier_properties
  bool get isLight => _current == AppThemeType.calm;

  @override
  ThemeData build() {
    _themeService = ref.read(appThemeProvider);
    loadSavedTheme();
    return _themeService.themeOf(_current);
  }

  void toggle() => setTheme(
    _current == AppThemeType.calm ? AppThemeType.vibrant : AppThemeType.calm,
  );

  void setTheme(AppThemeType newType) {
    if (newType == _current) return;
    _current = newType;
    state = _themeService.themeOf(newType);
    _saveTheme();
  }

  Future<void> loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('theme') ?? 0;
    setTheme(AppThemeType.values[index]);
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', _current.index);
  }
}
