import 'package:flutter/material.dart';

enum AppThemeType { calm, vibrant, lightBrown, darkBrown }

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

@immutable
class ChatPalette extends ThemeExtension<ChatPalette> {
  const ChatPalette({
    required this.sentMessageBubble,
    required this.receivedMessageBubble,
    required this.creamBackground,
    required this.lightBrownBorder,
    required this.darkBrownText,
    required this.mediumBrownText,
    required this.onlineIndicator,
  });

  final Color sentMessageBubble;
  final Color receivedMessageBubble;
  final Color creamBackground;
  final Color lightBrownBorder;
  final Color darkBrownText;
  final Color mediumBrownText;
  final Color onlineIndicator;

  @override
  ChatPalette copyWith({
    Color? sentMessageBubble,
    Color? receivedMessageBubble,
    Color? creamBackground,
    Color? lightBrownBorder,
    Color? darkBrownText,
    Color? mediumBrownText,
    Color? onlineIndicator,
  }) {
    return ChatPalette(
      sentMessageBubble: sentMessageBubble ?? this.sentMessageBubble,
      receivedMessageBubble:
          receivedMessageBubble ?? this.receivedMessageBubble,
      creamBackground: creamBackground ?? this.creamBackground,
      lightBrownBorder: lightBrownBorder ?? this.lightBrownBorder,
      darkBrownText: darkBrownText ?? this.darkBrownText,
      mediumBrownText: mediumBrownText ?? this.mediumBrownText,
      onlineIndicator: onlineIndicator ?? this.onlineIndicator,
    );
  }

  @override
  ThemeExtension<ChatPalette> lerp(
    ThemeExtension<ChatPalette>? other,
    double t,
  ) {
    if (other is! ChatPalette) return this;
    return ChatPalette(
      sentMessageBubble:
          Color.lerp(sentMessageBubble, other.sentMessageBubble, t)!,
      receivedMessageBubble:
          Color.lerp(receivedMessageBubble, other.receivedMessageBubble, t)!,
      creamBackground: Color.lerp(creamBackground, other.creamBackground, t)!,
      lightBrownBorder:
          Color.lerp(lightBrownBorder, other.lightBrownBorder, t)!,
      darkBrownText: Color.lerp(darkBrownText, other.darkBrownText, t)!,
      mediumBrownText: Color.lerp(mediumBrownText, other.mediumBrownText, t)!,
      onlineIndicator: Color.lerp(onlineIndicator, other.onlineIndicator, t)!,
    );
  }
}

class AppTheme {
  // --- Extensions (log + chat) ---
  static const _logDark = LogPalette(
    logColor: Color.fromARGB(255, 65, 203, 212),
  );
  static const _logLight = LogPalette(
    logColor: Color.fromARGB(255, 14, 49, 51),
  );

  static const _chatLight = ChatPalette(
    sentMessageBubble: Color(0xFF8D6E63),
    receivedMessageBubble: Color(0xFFEFEBE9),
    creamBackground: Color(0xFFF5F5F0),
    lightBrownBorder: Color(0xFFD7CCC8),
    darkBrownText: Color(0xFF3E2723),
    mediumBrownText: Color(0xFF5D4037),
    onlineIndicator: Color(0xFF4CAF50),
  );

  static const _chatDark = ChatPalette(
    sentMessageBubble: Color(0xFFD7CCC8),
    receivedMessageBubble: Color(0xFF3E2723),
    creamBackground: Color(0xFF1C1B1F),
    lightBrownBorder: Color(0xFF5D4037),
    darkBrownText: Color(0xFFEFEBE9),
    mediumBrownText: Color(0xFFD7CCC8),
    onlineIndicator: Color(0xFF4CAF50),
  );

  // --- Color schemes moved here so names are in scope ---
  static const ColorScheme _lightBrownColorScheme = ColorScheme(
    brightness: Brightness.light,

    // Primary
    primary: Color(0xFF8D6E63),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD7CCC8),
    onPrimaryContainer: Color(0xFF3E2723),

    // Secondary
    secondary: Color(0xFF6D4C41),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFEFEBE9),
    onSecondaryContainer: Color(0xFF3E2723),

    // Tertiary
    tertiary: Color(0xFFA1887F),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFF5F5F0),
    onTertiaryContainer: Color(0xFF5D4037),

    // Error
    error: Color(0xFFB71C1C),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    // Surface
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF3E2723),
    surfaceContainerHighest: Color(0xFFEFEBE9),
    onSurfaceVariant: Color(0xFF5D4037),

    // Outline
    outline: Color(0xFFD7CCC8),
    outlineVariant: Color(0xFFEFEBE9),

    // Shadow / misc
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF3E2723),
    onInverseSurface: Color(0xFFF5F5F0),
    inversePrimary: Color(0xFFD7CCC8),
  );

  static const ColorScheme _darkBrownColorScheme = ColorScheme(
    brightness: Brightness.dark,

    // Primary
    primary: Color(0xFFD7CCC8),
    onPrimary: Color(0xFF3E2723),
    primaryContainer: Color(0xFF5D4037),
    onPrimaryContainer: Color(0xFFD7CCC8),

    // Secondary
    secondary: Color(0xFFA1887F),
    onSecondary: Color(0xFF3E2723),
    secondaryContainer: Color(0xFF4E342E),
    onSecondaryContainer: Color(0xFFEFEBE9),

    // Tertiary
    tertiary: Color(0xFF8D6E63),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFF3E2723),
    onTertiaryContainer: Color(0xFFD7CCC8),

    // Error
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),

    // Surface
    surface: Color(0xFF1C1B1F),
    onSurface: Color(0xFFEFEBE9),
    surfaceContainerHighest: Color(0xFF3E2723),
    onSurfaceVariant: Color(0xFFD7CCC8),

    // Outline
    outline: Color(0xFF5D4037),
    outlineVariant: Color(0xFF3E2723),

    // Shadow / misc
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFEFEBE9),
    onInverseSurface: Color(0xFF3E2723),
    inversePrimary: Color(0xFF8D6E63),
  );

  /// Map every theme type to its ThemeData.
  static final Map<AppThemeType, ThemeData> _themes = {
    AppThemeType.calm: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal,
        brightness: Brightness.light,
      ),
      extensions: const [_logLight, _chatLight],
    ),
    AppThemeType.vibrant: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      extensions: const [_logDark, _chatDark],
    ),
    AppThemeType.lightBrown: ThemeData(
      useMaterial3: true,
      colorScheme: _lightBrownColorScheme,
      extensions: const [_logLight, _chatLight],
    ),
    AppThemeType.darkBrown: ThemeData(
      useMaterial3: true,
      colorScheme: _darkBrownColorScheme,
      extensions: const [_logDark, _chatDark],
    ),
  };

  /// Public getter – isolates the map so callers can’t mutate it.
  ThemeData themeOf(AppThemeType type) => _themes[type]!;
}
