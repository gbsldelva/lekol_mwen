import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/configs/themes/app_colors.dart';
import 'package:lekol_mwen/controllers/auth_controller.dart';
import 'package:lekol_mwen/widgets/common/main_button.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(gradient: mainGradient()),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/images/app_splash_logo.png",
            width: 200,
            height: 200,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Text(
              "This is a study app. Our aim is to help you get ready for the coming exams. Feel free to share it to your friends if you find it useful.",
              style: TextStyle(
                fontSize: 18,
                color: onSurfaceTextColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          MainButton(
            onTap: () {
              controller.signInWithGoogle();
            },
            child: Stack(children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                child: SvgPicture.asset("assets/icons/google.svg"),
              ),
              Center(
                child: Text(
                  "Sign in with Google",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
