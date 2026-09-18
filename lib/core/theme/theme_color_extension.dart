import 'package:dayuri/core/constants/app_colors.dart';
import 'package:dayuri/core/constants/app_images.dart';
import 'package:flutter/material.dart';

extension ThemeColors on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Color
  Color get white =>
      isDark ? AppColorsConstants.black : AppColorsConstants.white;

  Color get black =>
      isDark ? AppColorsConstants.white : AppColorsConstants.black;

  Color get greyC8 =>
      isDark ? AppColorsConstants.grey61 : AppColorsConstants.greyC8;

  Color get greyFA =>
      isDark ? AppColorsConstants.greyF5 : AppColorsConstants.greyFA;

  Color get grey89 =>
      isDark ? AppColorsConstants.greyBD : AppColorsConstants.grey89;

  Color get greyA3 =>
      isDark ? AppColorsConstants.grey9E : AppColorsConstants.greyA3;

  Color get greyF2 =>
      isDark ? AppColorsConstants.grey2C : AppColorsConstants.greyF2;

  Color get primaryBlueColor => AppColorsConstants.primaryBlueColor;

  // Image
  String get primaryColorLogoIcon => isDark
      ? AppImagesConstants.primaryColorWhiteLogoIcon
      : AppImagesConstants.primaryColorBlackLogoIcon;
}
