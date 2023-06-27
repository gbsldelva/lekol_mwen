import 'package:flutter/material.dart';
import 'package:lekol_mwen/configs/themes/sub_theme_data_mixin.dart';

const Color primaryColorLight = Color(0xFF042e60);
const Color secondColorLight = Color(0xFFB8E3FF);
const Color mainTextColorLigth = Color.fromARGB(255, 40, 40, 40);
const Color cardColor = Color.fromARGB(255, 254, 254, 255);
const scaffoldBackgroundColor = Colors.black12;

class LightTheme with SubThemeData {
  buildLigthTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      primaryColor: primaryColorLight,
      iconTheme: getIconTheme(),
      cardColor: cardColor,
      textTheme: getTextThemes().apply(
        bodyColor: mainTextColorLigth,
        displayColor: mainTextColorLigth,
      ),
    );
  }
}
