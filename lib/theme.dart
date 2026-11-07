// Maki Dice (Linux)
// github.com/andrewmichaelpowell

import 'package:flutter/material.dart';

class AppColors {
  static const green = Color(0xFF045030);
  static const orange = Color(0xFFF05C22);

  static const secondaryBackgroundLight = Color(0xFFEFEFF4);
  static const secondaryBackgroundDark = Color(0xFF1C1C1E);

  static const labelLight = Colors.black;
  static const labelDark = Colors.white;

  static const windowBackgroundLight = Colors.white;
  static const windowBackgroundDark = Colors.black;
}

ThemeData buildTheme(Brightness brightness) {
  final isLight = brightness == Brightness.light;
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor:
        isLight ? AppColors.windowBackgroundLight : AppColors.windowBackgroundDark,
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: AppColors.green,
      onPrimary: Colors.white,
      secondary: AppColors.orange,
      onSecondary: Colors.white,
      surface: isLight ? AppColors.windowBackgroundLight : AppColors.windowBackgroundDark,
      onSurface: isLight ? AppColors.labelLight : AppColors.labelDark,
      error: Colors.red,
      onError: Colors.white,
    ),
  );
}

Color secondaryBackgroundOf(BuildContext context) {
  final isLight = Theme.of(context).brightness == Brightness.light;
  return isLight ? AppColors.secondaryBackgroundLight : AppColors.secondaryBackgroundDark;
}

Color labelColorOf(BuildContext context) {
  final isLight = Theme.of(context).brightness == Brightness.light;
  return isLight ? AppColors.labelLight : AppColors.labelDark;
}
