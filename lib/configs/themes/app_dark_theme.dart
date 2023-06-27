import 'package:flutter/material.dart';
import 'package:lekol_mwen/configs/themes/sub_theme_data_mixin.dart';

const Color primaryDarkColor = Color(0xFF2E3C62);
const Color secondDarkColor = Color(0xFF99ACE1);
const Color mainTextColorDark = Colors.white;

class DarkTheme with SubThemeData {
  ThemeData buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
        iconTheme: getIconTheme(),
        textTheme: getTextThemes().apply(
          bodyColor: mainTextColorDark,
          displayColor: mainTextColorDark,
        ));
  }
}
