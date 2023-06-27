import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/configs/themes/ui_parameters.dart';

import 'app_dark_theme.dart';
import 'app_light_theme.dart';

const Color onSurfaceTextColor = Colors.white;
const Color correctAnswerColor = Color(0xFF3AC3CB);
const Color wrongAnswerColor = Color(0xFFF95187);
const Color notAnsweredColor = Color(0xFF2A3C65);

const mainGradientLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [primaryColorLight, secondColorLight],
);

const mainGradientDark = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [secondDarkColor, primaryDarkColor],
);

LinearGradient mainGradient() =>
    UIParameters.isDarkMode() ? mainGradientDark : mainGradientLight;

customScaffoldColor(BuildContext context) =>
    UIParameters.isDarkMode() ? const Color(0xFF2e3c62) : Colors.black12;

Color answerSelectedColor() => UIParameters.isDarkMode()
    ? Theme.of(Get.context!).cardColor.withOpacity(0.5)
    : Theme.of(Get.context!).primaryColor;

Color answerBorderColor() => UIParameters.isDarkMode()
    ? const Color(0xFF2e3c62)
    : const Color(0xFF2e3c62);
