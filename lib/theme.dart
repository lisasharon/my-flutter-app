import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF07141E);
  static const surface = Color(0xFF101E2B);
  static const card = Color(0xFF122230);
  static const elevated = Color(0xFF173044);
  static const search = Color(0xFF0C1924);
  static const green = Color(0xFF2EE56A);
  static const greenPressed = Color(0xFF24C85C);
  static const gold = Color(0xFFF0C44C);
  static const goldSoft = Color(0xFFE8B44A);
  static const cyan = Color(0xFF2AD4C8);
  static const text = Color(0xFFFFFFFF);
  static const muted = Color(0xFF8B9AAB);
  static const mutedDark = Color(0xFF6B7C8D);
  static const chip = Color(0xFF1A2C3A);
  static const orange = Color(0xFFFF8A1F);
  static const orangeDeep = Color(0xFFE85A1A);
}

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.green,
        surface: AppColors.surface,
      ),
      fontFamily: 'PingFang SC',
      useMaterial3: true,
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
