import 'package:flutter/material.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/share_preference/share_pref_helper.dart';

class ThemeRepository {
  Future<void> saveTheme(ThemeMode mode) async {
    SharedPrefHelper.setString(AppStringsConstants.themeModeKey, mode.name);
  }

  Future<ThemeMode> loadTheme() async {
    final value = await SharedPrefHelper.getString(
      AppStringsConstants.themeModeKey,
    );
    switch (value) {
      case AppStringsConstants.lightL:
        return ThemeMode.light;
      case AppStringsConstants.darkL:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
