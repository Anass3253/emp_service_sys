import 'package:flutter/material.dart';

class ThemeManager {
  ThemeManager._();

  // Define your custom colors
  static const Color _darkPrimary = Color(0xFFB13F26);
  static const Color _darkSecondary = Color(0xFF006080);
  static const Color _darkBackground = Color(0xFF607D8B);
  static const Color _darkColorText = Colors.white;

  static const Color _lightPrimary = Color(0xFFED6343);
  static const Color _secondgradient = Color(0xFF008DBF);
  static final Color _lightSecondry = Colors.lightBlueAccent.shade100;
  static const Color _lightBackground = Colors.white;
  static const Color _lightColorText = Colors.black;

  static const _appBarLightColor = LinearGradient(
    colors: [_lightPrimary, _secondgradient],
    begin: Alignment.centerLeft,
    end: AlignmentGeometry.centerRight,
  );
  static const _appBarDarkColor = LinearGradient(
    colors: [_darkPrimary, _darkSecondary],
    begin: Alignment.centerLeft,
    end: AlignmentGeometry.centerRight,
  );

  static final _scafoldLightColor = LinearGradient(
    colors: [const Color.fromARGB(255, 235, 166, 61), _lightSecondry],
    begin: AlignmentGeometry.topLeft,
    end: AlignmentGeometry.bottomRight,
    tileMode: TileMode.clamp,
  );
  static const _scafoldDarkColor = LinearGradient(
    colors: [Color(0xFFB3761F), Color(0xFF0096C7)],
    begin: AlignmentGeometry.topLeft,
    end: AlignmentGeometry.bottomRight,
    tileMode: TileMode.clamp,
  );

  static final ThemeData lightTheme = ThemeData(
    extensions: <ThemeExtension<dynamic>>[
      const GradientTheme(appBarGradient: _appBarLightColor),
      BackgroundTheme(scaffoldGradient: _scafoldLightColor),
    ],
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _lightPrimary,
    scaffoldBackgroundColor: _lightBackground,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    cardColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: _darkPrimary,
      surface: _lightBackground,
      secondary: Color(0xFF00547c),
      tertiary: _darkSecondary,
      onPrimary: _lightColorText,
      onTertiary: _darkSecondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF00547c),
      centerTitle: true,
    ),
    fontFamily: "Verdana",
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    extensions: const <ThemeExtension<dynamic>>[
      GradientTheme(appBarGradient: _appBarDarkColor),
      BackgroundTheme(scaffoldGradient: _scafoldDarkColor),
    ],
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(208, 16, 24, 40),
    scaffoldBackgroundColor: _darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: _lightPrimary,
      surface: _darkBackground,
      secondary: Color(0xFF00547c),
      tertiary: _secondgradient,
      onTertiary: _lightColorText,
      onPrimary: _darkColorText,
    ),
    cardColor: Colors.black87,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF00547c),
    ),
    fontFamily: "Poppins",
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontFamily: "Poppins"),
      bodyMedium: TextStyle(color: Colors.white, fontFamily: "Poppins"),
    ),
  );
}

// appBar backgorund theme
class GradientTheme extends ThemeExtension<GradientTheme> {
  final Gradient appBarGradient;

  const GradientTheme({required this.appBarGradient});

  @override
  GradientTheme copyWith({Gradient? appBarGradient}) {
    return GradientTheme(appBarGradient: appBarGradient ?? this.appBarGradient);
  }

  @override
  GradientTheme lerp(ThemeExtension<GradientTheme>? other, double t) {
    if (other is! GradientTheme) return this;
    return GradientTheme(
      appBarGradient: Gradient.lerp(appBarGradient, other.appBarGradient, t)!,
    );
  }
}

// scafold backgorund theme
class BackgroundTheme extends ThemeExtension<BackgroundTheme> {
  final Gradient scaffoldGradient;

  const BackgroundTheme({required this.scaffoldGradient});

  @override
  BackgroundTheme copyWith({Gradient? scaffoldGradient}) {
    return BackgroundTheme(
      scaffoldGradient: scaffoldGradient ?? this.scaffoldGradient,
    );
  }

  @override
  BackgroundTheme lerp(ThemeExtension<BackgroundTheme>? other, double t) {
    if (other is! BackgroundTheme) return this;
    return BackgroundTheme(
      scaffoldGradient: Gradient.lerp(
        scaffoldGradient,
        other.scaffoldGradient,
        t,
      )!,
    );
  }
}
