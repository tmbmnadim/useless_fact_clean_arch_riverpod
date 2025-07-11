import 'package:flutter/material.dart';

enum AppThemeType { calm, vibrant }

@immutable
class LogPalette extends ThemeExtension<LogPalette> {
  const LogPalette({required this.logColor});

  final Color logColor;

  @override
  LogPalette copyWith({Color? logColor}) =>
      LogPalette(logColor: logColor ?? this.logColor);

  @override
  ThemeExtension<LogPalette> lerp(ThemeExtension<LogPalette>? other, double t) {
    if (other is! LogPalette) return this;
    return LogPalette(logColor: Color.lerp(logColor, other.logColor, t)!);
  }
}

class AppTheme {
  // Emoji colors (shared between themes here, but you can vary them).
  static const _logDark = LogPalette(
    logColor: Color.fromARGB(255, 65, 203, 212),
  );
  static const _logLight = LogPalette(
    logColor: Color.fromARGB(255, 14, 49, 51),
  );

  /// Map every theme type to its ThemeData.
  static final Map<AppThemeType, ThemeData> _themes = {
    AppThemeType.calm: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal,
        brightness: Brightness.light,
      ),
      extensions: const [_logLight],
    ),
    AppThemeType.vibrant: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      extensions: const [_logDark],
    ),
  };

  /// Public getter – isolates the map so callers can’t mutate it.
  ThemeData themeOf(AppThemeType type) => _themes[type]!;
}
