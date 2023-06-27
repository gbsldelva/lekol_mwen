import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/configs/themes/app_colors.dart';

import '../../widgets/app_circle_button.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: mainGradient()),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.star,
              size: 65,
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              "This is a study app. Our aim is to help you get ready for the coming exams. Feel free to share it to your friends if you find it useful.",
              style: TextStyle(
                fontSize: 18,
                color: onSurfaceTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 40.0,
            ),
            AppCircleButton(
              onTap: () => Get.offAllNamed("/home"),
              child: const Icon(
                Icons.arrow_forward,
                size: 35,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
