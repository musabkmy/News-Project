import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_today/themes/app_colors.dart';
import 'package:news_today/themes/app_text_styles.dart';

ThemeData appLightTheme() {
  final appColors = AppLightColors();
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: appColors.primaryColor,
    appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.transparent),
  );
}

ThemeData appDarkTheme() {
  return ThemeData(
    brightness: Brightness.light,
  );
}

extension ColorsExtension on ThemeData {
  AppColors get appColors {
    return brightness == Brightness.light ? AppLightColors() : AppLightColors();
  }
}

extension TextStylesExtension on ThemeData {
  AppTextStyles get appTextStyles {
    return brightness == Brightness.light
        ? AppTextStyles(AppLightColors())
        : AppTextStyles(AppDarkColors());
  }
}
