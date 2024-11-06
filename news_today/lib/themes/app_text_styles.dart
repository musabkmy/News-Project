import 'package:flutter/widgets.dart';
import 'package:news_today/themes/app_colors.dart';

class AppTextStyles {
  AppTextStyles(this.appColors);
  final AppColors appColors;

  TextStyle get headline => TextStyle(
        fontFamily: 'Georgia',
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w700,
        color: appColors.pinkColor,
        fontSize: 24.0,
      );

  TextStyle get titleLarge => TextStyle(
        fontFamily: 'Georgia',
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        color: appColors.textTitleColor,
        fontSize: 22.0,
      );

  TextStyle get titleMediumItalic => TextStyle(
        fontFamily: 'Caros',
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w600,
        color: appColors.textBodyColor,
        fontSize: 18.0,
      );

  TextStyle get titleMedium => TextStyle(
        fontFamily: 'Caros',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: appColors.textBodyColor,
        fontSize: 18.0,
      );

  TextStyle get bodyLarge => TextStyle(
        fontFamily: 'Caros',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        color: appColors.textBodyColor,
        fontSize: 16.0,
      );

  TextStyle get bodyLarge2 => TextStyle(
        fontFamily: 'Caros',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        color: appColors.textBody2Color,
        fontSize: 16.0,
      );

  TextStyle get bodyMedium => TextStyle(
        fontFamily: 'Caros',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: appColors.textBodyColor,
        fontSize: 16.0,
      );

  TextStyle get bodyMedium2 => TextStyle(
        fontFamily: 'Caros',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: appColors.textBody2Color,
        fontSize: 16.0,
      );

  TextStyle get bodyBoldSmall => TextStyle(
        fontFamily: 'Caros',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: appColors.textBodyColor,
        fontSize: 14.0,
      );

  TextStyle get bodySmall => TextStyle(
        fontFamily: 'Caros',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: appColors.textBodySmallColor,
        fontSize: 14.0,
      );

  TextStyle get bodySmallItalic => TextStyle(
        fontFamily: 'Caros',
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.normal,
        color: appColors.textBodySmallColor,
        fontSize: 14.0,
      );
}
